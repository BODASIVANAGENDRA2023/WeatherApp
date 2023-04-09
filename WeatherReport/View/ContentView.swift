//
//  ContentView.swift
//  WeatherReport
//
//  Created by BODA SIVA NAGENDRA on 09/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherViewModel = WeatherViewModel() // Create a view model to handle weather data
    @State private var searchText = "" // The location to search for
    
    var body: some View {
        VStack {
            Text("Weather App")
                .font(.title)
            SearchBar(text: $searchText, onSearch: {
                weatherViewModel.fetchWeather(forLocation: searchText)
            })
            //Getting Data from the ViewModel and Displaying on the View
            if let weatherData = weatherViewModel.weatherData {
                VStack {
                    Text("\(weatherData.name)")
                        .font(.headline)
                    Text("\(weatherData.weather.first?.description ?? "" )")
                        .font(.title3)
                    Text("\(Int(weatherData.main.temp - 273.15))°C")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("\(weatherData.main.humidity)% humidity")
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/w/\(weatherData.weather[0].icon).png"))
                        .fixedSize()
                }
                .padding() // Add Padding
                .foregroundColor(.white)
                .background(Color.blue)
                .opacity(0.75)
                .cornerRadius(20)
                
            } else if let errorMessage = weatherViewModel.errorMessage {
                Text(errorMessage)
            }
            Spacer()
        }.padding()
    }
}

struct SearchBar: View {
    @Binding var text: String // A binding to the search text entered by the user
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search location", text: $text, onCommit: onSearch) // A text field for entering search text
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: onSearch) {
                Text("Search")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

