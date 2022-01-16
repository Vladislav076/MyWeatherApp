//
//  WeatherViewController.swift
//  MyWeatherApp
//
//  Created by Владислав on 17.01.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var searchTextFiled: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManeger = WeatherManeger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextFiled.delegate = self
        weatherManeger.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextFiled.endEditing(true)
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFiled.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextFiled.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextFiled.text {
        weatherManeger.fetchWeather(cityName: city)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManeger, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
