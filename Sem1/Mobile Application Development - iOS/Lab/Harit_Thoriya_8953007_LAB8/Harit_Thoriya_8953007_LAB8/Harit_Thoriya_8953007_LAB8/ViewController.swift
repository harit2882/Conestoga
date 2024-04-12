//
//  ViewController.swift
//  Harit_Thoriya_8953007_LAB8
//
//  Created by thor on 2023-11-28.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    fileprivate let locationManager : CLLocationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                // Access the user's location through the 'location' variable
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
                
                fetchWheatherData(latitude: latitude, longitude: longitude)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
    
    func fetchWheatherData(latitude: Double,longitude: Double){
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=7df2d7ba61cc4970392158e18187c456&units=metric"
        
        let urlSession = URLSession(configuration: .default)
        
        let url = URL(string: urlString)
        
        if let url = url{
            
            let dataTask = urlSession.dataTask(with: url) { (data,response,error) in
                
                if let data = data {
                    
                    print(data)
                    
                    let jsonDecoder = JSONDecoder()
                    
                    do{
                        var readableData = try jsonDecoder.decode(Welcome.self, from: data)
                        
                        
                        print("temp = \(readableData.main.temp)")
                        
                        
                        DispatchQueue.main.async {
                            self.cityLabel.text = readableData.name
                            self.weatherLabel.text = readableData.weather.last?.main
                            if let url = URL(string: "https://openweathermap.org/img/wn//\(readableData.weather.last?.icon ?? "").png" ) {
                                self.downloadImage(from: url)
                            }
                            self.tempLabel.text = "\(readableData.main.temp) °C"
                            self.humidityLabel.text = "Humdity : \(readableData.main.humidity)%"
                            self.windLabel.text = "Wind : \(readableData.wind.speed*3.6) km/h"
                        }
                        
                    }catch let decodingError {
                        print("Error decoding JSON: \(decodingError)")
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    
    func downloadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self.weatherImage.image = image
                    }
                }
            }.resume()
        }
    
}
    
   

   
   



