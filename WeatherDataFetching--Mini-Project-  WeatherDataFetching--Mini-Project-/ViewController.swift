//
//  ViewController.swift
//  WeatherDataFetching--Mini-Project-  WeatherDataFetching--Mini-Project-
//
//  Created by Mac on 26/04/24.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func fetchWeatherData(for country: String) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=65a7aea3e395474187a20653220504&q=\(country)&aqi=no") else {
            print("Invalid URL")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error occurred while accessing data with URL")
                return
            }
            
            do {
                let fullWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                
                DispatchQueue.main.async {
                    self.updateUI(with: fullWeatherData)
                }
            } catch {
                print("Error occurred while decoding JSON into Swift structure: \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    func updateUI(with data: WeatherData) {
        updateTimeLabel.text = "Updated: \(data.current.last_updated)"
        regionLabel.text = "Region: \(data.location.region)"
        countryLabel.text = "Country: \(data.location.country)"
        temperatureLabel.text = "Temperature (Celsius): \(data.current.temp_c)"
        humidityLabel.text = "Humidity: \(data.current.humidity)"
        windLabel.text = "Wind (km/h): \(data.current.wind_kph)"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            fetchWeatherData(for: searchText)
            searchBar.resignFirstResponder()
        }
    }
    
    @IBAction func refreshData(_ sender: Any) {
        if let searchText = searchBar.text {
            fetchWeatherData(for: searchText)
        }
    }
}
