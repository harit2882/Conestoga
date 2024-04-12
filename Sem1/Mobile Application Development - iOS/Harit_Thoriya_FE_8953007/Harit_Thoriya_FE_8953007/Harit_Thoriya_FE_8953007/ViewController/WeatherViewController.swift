//
//  WeatherViewController.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.


import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var myTabBar: UITabBar!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var weatherData: WeatherModel?
    var history: History?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTabBar.delegate = self
        
        setupNavigationBar()
        
        loadWeatherDataFromHome()
    }
    
    // Custum tabbar
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        CommonTabBarHandler.tabSelection(for: item, navigationController: navigationController)
    }
    
    // navigation setup
    func setupNavigationBar() {
        let homeButton = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(homeButtonTapped))
        navigationItem.leftBarButtonItem = homeButton
        navigationItem.title = "Weather"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func loadWeatherDataFromHome() {
        if let history = history {
            cityNameLabel.text = history.searchName
            convertAddress(address: history.searchName ?? "")
        } else {
            history = History(context: content)
            history?.historyId = UUID()
            history?.dateTime = Date()
            history?.originSource = "Weather"
        }
    }
    
    @objc func homeButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "Home") as? MainViewController {
            navigationController?.setViewControllers([homeViewController], animated: true)
        }
    }
    
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Where would you like to go?\nEnter your destination here", message: nil, preferredStyle: .alert)
        
        var destinationTextField: UITextField?
        
        alertController.addTextField { textField in
            textField.placeholder = "Destination"
            destinationTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let goAction = UIAlertAction(title: "Go", style: .default) { _ in
            if let destination = destinationTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                self.cityNameLabel.text = destination
                self.convertAddress(address: destination)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(goAction)
        
        present(alertController, animated: true)
    }
    
    
    // API calling for weather data logic
    func fetchWeatherData(latitude: Double, longitude: Double, destination: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=7df2d7ba61cc4970392158e18187c456&units=metric"
        
        let urlSession = URLSession(configuration: .default)
        
        let url = URL(string: urlString)
        
        if let url = url{
            
            let dataTask = urlSession.dataTask(with: url) { (data,response,error) in
                
                if let data = data {
                    
                    print(data)
                    
                    let jsonDecoder = JSONDecoder()
                    
                    do{
                        let readableData = try jsonDecoder.decode(WeatherModel.self, from: data)
                        
                        self.weatherData = readableData
                        
                        print("temp = \(readableData.main.temp)")
                        
                        DispatchQueue.main.async {
                            self.cityLabel.text = readableData.name
                            self.weatherLabel.text = readableData.weather.last?.main
                            if let url = URL(string: "https://openweathermap.org/img/wn//\(readableData.weather.last?.icon ?? "").png" ) {
                                self.downloadImage(from: url)
                            }
                            self.tempLabel.text = "\(readableData.main.temp) °C"
                            self.humidityLabel.text = "Humdity : \(readableData.main.humidity)%"
                            self.windLabel.text = "Wind : \(String(format: "%.2f", readableData.wind.speed * 3.6)) km/h"
                            
                        }
                        
                        self.saveWeatherHistory(destination: destination)
                        
                    }catch let decodingError {
                        print("Error decoding JSON: \(decodingError)")
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    // save weather data to core data databse
    func saveWeatherHistory(destination: String) {
        guard let history = history else {
            print("History is nil")
            return
        }
        
        history.searchName = destination
        
        let weather = Weather(context: content)
        weather.resultId = UUID()
        weather.humidity = Int16(weatherData?.main.humidity ?? 0)
        weather.temprature = weatherData?.main.temp ?? 0
        weather.wind = weatherData?.wind.speed ?? 0
        weather.weatherType = weatherData?.weather.last?.main
        
        history.result = weather
        
        do {
            try content.save()
            print("Save Successfully")
        } catch {
            print("Error saving data")
        }
    }
    
    // image download for weather data
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
    
    // convert string address to location
    func convertAddress(address: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) { placemarks, error in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                print("No location found")
                return
            }
            print(location)
            self.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, destination: address)
        }
    }
}
