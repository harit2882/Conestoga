//
//  MainViewController.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController,UITabBarDelegate, CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var myTabBar: UITabBar!

    @IBOutlet weak var mapView: MKMapView!

    private var locationManager = CLLocationManager()

    var history: History?

    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext



    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up tab bar view
        myTabBar.delegate = self

        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Set up map view
        mapView.delegate = self
        mapView.showsUserLocation = true

    }

    //Custus tab bar
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        CommonTabBarHandler.tabSelection(for: item, navigationController: navigationController)
    }

    //location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{

            manager.startUpdatingLocation()

            render (location)

        }
    }

    func render (_ location: CLLocation) {

        let coordinate = CLLocationCoordinate2D (latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )

        //span settings determine how much to zoom into the map - defined details
        let span = MKCoordinateSpan(latitudeDelta: 4.9, longitudeDelta: 4.9)

        let region = MKCoordinateRegion(center: coordinate, span: span)

        let pin = MKPointAnnotation ()

        pin.coordinate = coordinate

        mapView.addAnnotation(pin)

        mapView.setRegion(region, animated: true)

    }

// Alet controll boc to direct search for news, weather and direction
    @IBAction func discoverWorldButton(_ sender: UIButton) {

        let alertController = UIAlertController(title: "Where would ou like to go ?\nEnter your destination",
                                                message: nil,
                                                preferredStyle: .alert)

        var destinationTextField: UITextField?

        alertController.addTextField(){
            textField in textField.placeholder = "Destination"

            destinationTextField = textField
        }

        //news page navigation
        let newsButton = UIAlertAction(title: "News", style: .default){_ in

            if let destination = destinationTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {

                self.history = History(context: self.content)
                self.history?.historyId = UUID()
                self.history?.searchName = destination
                self.history?.dateTime = Date()
                self.history?.originSource = "Home"

                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                if let newsViewController = storyboard.instantiateViewController(withIdentifier: "News") as? NewsViewController {

                    newsViewController.history = self.history
                    self.navigationController?.setViewControllers([newsViewController], animated: false)
                }

            }
        }

        // direction page navigation
        let directionButton = UIAlertAction(title: "Direction", style: .default){_ in

            if let destination = destinationTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {

                self.history = History(context: self.content)
                self.history?.historyId = UUID()
                self.history?.searchName = destination
                self.history?.dateTime = Date()
                self.history?.originSource = "Home"

                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                if let directionViewController = storyboard.instantiateViewController(withIdentifier: "Map") as? MapViewController {

                    directionViewController.history = self.history
                    self.navigationController?.setViewControllers([directionViewController], animated: false)
                }

            }
        }

        //weather page navigation
        let weatherButton = UIAlertAction(title: "Weather", style: .default){_ in

            if let destination = destinationTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {

                self.history = History(context: self.content)
                self.history?.historyId = UUID()
                self.history?.searchName = destination
                self.history?.dateTime = Date()
                self.history?.originSource = "Home"

                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                if let weatherViewController = storyboard.instantiateViewController(withIdentifier: "Weather") as? WeatherViewController {

                    weatherViewController.history = self.history
                    self.navigationController?.setViewControllers([weatherViewController], animated: false)
                }

            }

        }

        alertController.addAction(newsButton)
        alertController.addAction(directionButton)
        alertController.addAction(weatherButton)

        present(alertController, animated: true)


    }

}
