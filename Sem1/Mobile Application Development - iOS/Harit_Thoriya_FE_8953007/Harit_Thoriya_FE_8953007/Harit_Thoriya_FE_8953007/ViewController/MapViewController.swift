//
//  MapViewController.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//

import UIKit
import MapKit
import CoreLocation
import CoreData


class MapViewController: UIViewController,UITabBarDelegate,CLLocationManagerDelegate,MKMapViewDelegate  {
    
    
    @IBOutlet weak var myTabBar: UITabBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var bikeButton: UIButton!
    @IBOutlet weak var walkButton: UIButton!
    
    
    @IBAction func zoomSlider(_ sender: UISlider) {
        let zoomLevel = Double(sender.value)
        updateMapZoomLevel(zoomLevel: zoomLevel,location : location)
    }
    
    
    @IBAction func carButtonTapped(_ sender: UIButton) {
        updateButtonColor(sender)
        transportType = .automobile
        
    }
    
    @IBAction func bikeButtonTapped(_ sender: UIButton) {
        updateButtonColor(sender)
        transportType = .any
    }
    
    @IBAction func walkButtonTapped(_ sender: UIButton) {
        updateButtonColor(sender)
        transportType = .walking
    }
    
    
    private var locationManager = CLLocationManager()
    
    private var location: CLLocation?
    
    private var destinationLocation: CLLocation?
    
    private var destination : String?
    
    private var totalDistance : Double = 0
    
    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var history: History? = nil
    
    var direction: Direction?
    
    var startPoint: String?
    
    private var transportType: MKDirectionsTransportType = .automobile{
        
        didSet{
            if let destinationCoordinate = destinationLocation?.coordinate {
                showRoute(desitiationCor: destinationCoordinate,transportType: transportType)
                
            }else{
                let alertController = UIAlertController(title: "Alert !", message: "Insert destination by clicking on +", preferredStyle: .alert)
                
                // Add an OK button to the alert
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertController.addAction(okAction)
                
                
                // Present the alert
                present(alertController, animated: true, completion: nil)
                
                resetButton()
                
            }
        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        myTabBar.delegate = self
        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Set up map view
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        
        let homeButton = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(homeButtonTapped))
        navigationItem.leftBarButtonItem = homeButton
        navigationItem.title = "Directions"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        // Check if the history object is not nil
        if let history = history {
            
            self.convertAddress(address: history.searchName!)
            
        } else {
            // History object is nil, handle it accordingly
            print("History is nil")
        }
        
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        CommonTabBarHandler.tabSelection(for: item, navigationController: navigationController)
    }
    
    @objc func homeButtonTapped() {
        // Navigate to the home view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "Home") as? MainViewController {
            navigationController?.setViewControllers([homeViewController], animated: true)
        }
    }
    
    // add button to search direction alert
    @objc func addButtonTapped() {
        
        let alertController = UIAlertController(title: "Where would ou like to go ?\nEnter your destination here",
                                                message: nil,
                                                preferredStyle: .alert)
        
        var destinationTextField: UITextField?
        
        alertController.addTextField{ textField in
            textField.placeholder = "Destination"
            destinationTextField = textField
        }
        
        let cancleButton = UIAlertAction(title: "Cancle", style: .cancel)
        
        let goButton = UIAlertAction(title: "Go", style: .default){_ in
            
            if let destination = destinationTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                
                self.convertAddress(address: destination)
                
                self.destination = destination
            }
        }
        
        
        alertController.addAction(cancleButton)
        alertController.addAction(goButton)
        
        present(alertController, animated: true)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            
            manager.startUpdatingLocation()
            
            self.location = location
            
            getCityName(from: location) { cityName in
                if let cityName = cityName {
                    self.startPoint = cityName
                    print("City Name: \(cityName)")
                } else {
                    print("City name not found")
                }
            }
            
        }
    }
    
    // Slide var zoom logic
    func updateMapZoomLevel(zoomLevel:Double,location:CLLocation?){
        
        let updatedZoomLevel = 10 - zoomLevel
        
        let coordinate = CLLocationCoordinate2D (latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude )
        // Update the latitudeDelta and longitudeDelta of the MKCoordinateSpan
        let span = MKCoordinateSpan(latitudeDelta: updatedZoomLevel, longitudeDelta: updatedZoomLevel)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let pin = MKPointAnnotation ()
        
        pin.coordinate = coordinate
        
        mapView.addAnnotation(pin)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    
    // Convert String address to location
    func convertAddress(address: String) {
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) {
            
            (placemarks, error) in
            
            guard let placemarks = placemarks,
                  
                    let location = placemarks.first?.location
                    
            else {
                
                print ("no location found")
                
                return
                
            }
            print(location)
            
            self.destinationLocation = location
            self.carButton.tintColor = .systemBlue
            self.showRoute(desitiationCor: location.coordinate,transportType: self.transportType)
            
        }
        
    }
    
    
    func showRoute(desitiationCor : CLLocationCoordinate2D,transportType: MKDirectionsTransportType) {
        
        // Resetting Overly
        mapView.removeOverlays(mapView.overlays)
        
        let sourceCoordinate = (locationManager.location?.coordinate)!
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: desitiationCor)
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        let destinationRequest = MKDirections.Request()
        
        
        //start and end
        destinationRequest.source = sourceItem
        destinationRequest.destination = destinationItem
        destinationRequest.transportType = transportType
        // one route = false multi = true
        destinationRequest.requestsAlternateRoutes = false
        // submit request to calculate directions
        let directions = MKDirections(request: destinationRequest)
        
        
        directions.calculate { (response, error) in
            
            // if there is a response make it the response else make error
            
            if let error = error {
                print("Error calculating directions: \(error.localizedDescription)")
                return
            }
            guard let response = response, let route = response.routes.first else {
                print("No valid route found")
                return
            }
            
            self.totalDistance = route.distance / 1000.0
            
            print("Total Distance = \(self.totalDistance)")
            // adding overlay to routes
            self.mapView.addOverlay(route.polyline,level: .aboveRoads)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
            // setting endpoint pin
            let pin = MKPointAnnotation()
            
            pin.coordinate = desitiationCor
            
            pin.title = "Destination"
            
            self.mapView.addAnnotation(pin)
        }
        
       saveMapHistory(distance: self.totalDistance)
    }
    
    // Create a polyline overlay
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let polyline = overlay as? MKPolyline {
            
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            
            if transportType == .walking {
                renderer.lineWidth = 2
                // Set the line dash pattern for walking route (dotted line)
                renderer.lineDashPattern = [3, 8]             }
            return renderer
        }
        return MKOverlayRenderer()
        
    }
    
    private func resetButton() {
        // Reset the color of all buttons
        carButton.tintColor = .black
        bikeButton.tintColor = .black
        walkButton.tintColor = .black
    }
    
    // update trasport type color
    func updateButtonColor(_ selectedButton: UIButton) {
        resetButton()
        
        // Change the color of selected button
        selectedButton.tintColor = .systemBlue
    }
    

    private func saveMapHistory(distance: Double) {
        guard let history = self.history else {
            // Create new history
            createNewHistory(distance: distance)
            return
        }

        guard let result = history.result, let direction = result as? Direction else {
            // Create new direction
            createNewDirection(distance: distance)
            return
        }

        // Update existing direction
        updateExistingDirection(direction: direction)

        // Save changes
        do {
            try self.content.save()
            print("Save Successfully")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    private func createNewHistory(distance: Double) {
        self.history = History(context: content)
        self.history?.historyId = UUID()
        self.history?.dateTime = Date()
        self.history?.searchName = destination
        self.history?.originSource = "Direction"
        createNewDirection(distance: distance)
        self.history?.result = self.direction
    }

    private func createNewDirection(distance: Double) {
        self.direction = Direction(context: content)
        self.direction?.resultId = UUID()
        self.direction?.startPoint = self.startPoint
        self.direction?.endPoint = destination
        self.direction?.distance = self.totalDistance
        self.direction?.travelType = getTravelTypeString(from: transportType)
    }

    private func updateExistingDirection(direction: Direction) {
        direction.travelType = getTravelTypeString(from: transportType)
        // Add any other properties you want to update
    }

    
    // get City name base on location
    func getCityName(from location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion(nil)
                return
            }

            if let city = placemark.locality {
                completion(city)
            } else {
                // If locality is nil, you can try using other address components like subLocality, administrativeArea, etc.
                completion(nil)
            }
        }
    }

    // Function to get a Direction object with a specific resultId
    private func getDirection(with resultId: UUID) -> Direction? {
        let fetchRequest: NSFetchRequest<Direction> = Direction.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "resultId == %@", resultId as CVarArg)

        do {
            let directions = try content.fetch(fetchRequest)
            return directions.first
        } catch {
            print("Error fetching Direction: \(error.localizedDescription)")
            return nil
        }
    }
    
    // geting type of travel
    func getTravelTypeString(from transportType: MKDirectionsTransportType) -> String {
        switch transportType {
        case .automobile:
            return "Car"
        case .walking:
            return "Walking"
        case .any:
            return "Bike"
        default:
            return "Unknown"
        }
    }

}

