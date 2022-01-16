//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Владислав on 17.01.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManeger, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManeger {
    let weather = "https://api.openweathermap.org/data/2.5/weather?appid=6f7da167c384e163d78080208aa63848&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weather)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather =  self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(WeatherDate.self, from: weatherData )
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
   
    
}
