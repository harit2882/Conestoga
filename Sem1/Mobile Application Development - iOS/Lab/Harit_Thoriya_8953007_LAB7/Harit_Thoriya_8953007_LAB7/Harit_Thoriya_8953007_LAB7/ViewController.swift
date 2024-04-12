//
//  ViewController.swift
//  Harit_Thoriya_8953007_LAB7
//
//  Created by Harit Thoriya on 2023-11-16.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startTripButton(_ sender: UIButton) {
    
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        onGoingTripView.backgroundColor = UIColor.systemGreen
        
    }
    
    @IBAction func stopTripButton(_ sender: UIButton) {
        
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = false
        onGoingTripView.backgroundColor = UIColor.systemGray
        
    }
    @IBOutlet weak var currentSpeedValue: UILabel!
    
    @IBOutlet weak var maxSpeedValue: UILabel!
    
    @IBOutlet weak var averageSpeedValue: UILabel!
    
    @IBOutlet weak var distanceValue: UILabel!
    
    @IBOutlet weak var maxAccelerationValue: UILabel!
    
    @IBOutlet weak var exceedSpeedView: UIView!
    
    @IBOutlet weak var onGoingTripView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var startLocation : CLLocation!
    var lastLocation : CLLocation!
    var traveledDistance : Double = 0
    var prevSpeed : Double = 0
    var maxAccValue : Double = 0
    var prevTime : Date? = Date()
    fileprivate let locationManager : CLLocationManager = CLLocationManager()
    
    var speedArray:[Double] = []

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        manager.startUpdatingLocation()
        render(location)
        
        if startLocation == nil{
            startLocation = locations.first!
        }
        else{
            let lastLocation = locations.last!
            let distance = startLocation.distance(from: lastLocation)
            startLocation = lastLocation
            traveledDistance = traveledDistance + distance;
        }
        distanceValue.text = "\(round(traveledDistance*100/1000)/100.0) km"
        currentSpeedValue.text = "\(String(format: "%.2f", location.speed * 3.6)) km/h"
        speedArray.append(location.speed*3.6)
        maxSpeedValue.text = "\(String(format: "%.2f", speedArray.max() ?? 0)) km/h"

        var totalSpeed : Double = 0.0
        speedArray.forEach{ speed in
            totalSpeed = totalSpeed + speed
            
        }

        let avgSpeedMeasured = totalSpeed/Double(speedArray.count)
        if(prevSpeed != nil){
            let speedDifference = location.speed - prevSpeed
            let timeDifference = Date().timeIntervalSince(prevTime!)
            let acceleration = speedDifference/timeDifference
            maxAccValue =  max(acceleration, maxAccValue)
            maxAccelerationValue.text =
                String (format : "%.3f", maxAccValue) + "m/s^2"
        }
        prevSpeed = location.speed
        prevTime = Date()
        averageSpeedValue.text = "\(String(format: "%.2f", avgSpeedMeasured)) km/h"
        if(location.speed * 3.6 )>115{
            exceedSpeedView.backgroundColor = UIColor.systemRed
        }
        else{
            exceedSpeedView.backgroundColor = UIColor.white
        }
    }
    
    
    func render (_ location: CLLocation) {

           let coordinate = CLLocationCoordinate2D (latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )

           //span settings determine how much to zoom into the map - defined details
           let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta:0.05)

           let region = MKCoordinateRegion(center: coordinate, span: span)

           let pin = MKPointAnnotation ()

           pin.coordinate = coordinate

           mapView.addAnnotation(pin)

           mapView.setRegion(region, animated: true)

       }
    
    
    
    
}

