//
//  WeatherViewModel.swift
//  WeatherReport
//
//  Created by BODA SIVA NAGENDRA on 09/04/23.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData? // The current weather data
    @Published var errorMessage: String? // An error message, if any
    
    let weatherAPI = WeatherAPI()    // The WeatherAPI service that provides the data
    
    // Call the fetchWeather method of the weatherAPI object with the given location and a completion handler
    func fetchWeather(forLocation location: String) {
        weatherAPI.fetchWeather(forLocation: location) { [weak self] (weatherData, error) in
            // Dispatch the UI updates to the main queue
            DispatchQueue.main.async {
                // If the fetched weather data is not nil, assign it to the weatherData property
                if let weatherData = weatherData {
                    self?.weatherData = weatherData
                } else if let error = error { // Otherwise, if there was an error, assign the error message to the errorMessage property
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
