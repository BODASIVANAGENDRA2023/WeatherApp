//
//  WeatherAPI.swift
//  WeatherReport
//
//  Created by BODA SIVA NAGENDRA on 09/04/23.
//

import Foundation

class WeatherAPI {
    let apiKey = "4df358a92da9c9f7c53d578cf4321d48"
    
    func fetchWeather(forLocation location: String, completion: @escaping (WeatherData?, Error?) -> Void) {
        // Build the URL for the weather API endpoint
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(location)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        // Create a URLSessionDataTask to fetch the weather data from the API
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for any errors or invalid response
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                // Decode the JSON data into a WeatherData object
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(weatherData, nil) // Return the fetched WeatherData object
            } catch {
                completion(nil, error) // Return any decoding error
            }
        }.resume() // Start the URLSessionDataTask
    }
}
