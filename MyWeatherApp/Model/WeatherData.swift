//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Владислав on 17.01.2022.
//

import Foundation

struct WeatherDate: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
