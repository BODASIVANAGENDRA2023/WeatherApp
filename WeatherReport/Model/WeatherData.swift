//
//  WeatherData.swift
//  WeatherReport
//
//  Created by BODA SIVA NAGENDRA on 09/04/23.
//

import Foundation

// This struct represents a weather object returned by the OpenWeatherMap API.
struct WeatherData: Codable, Identifiable {
    let id: Int
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}
