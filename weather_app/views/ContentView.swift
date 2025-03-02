//
//  ContentView.swift
//  weather_app
//
//  Created by Viviana Tran on 3/1/25.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var locationManager =  LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if weather != nil {
                    Text("weather data fetched")
                
                } else {
                    LoadingView()
                        .task{
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error fetching weather data: \(error)")
                            }
                        }
                }
            }
            else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        } .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354)) //change this up
            .preferredColorScheme(.dark)
        
    }
}

struct ContentView_previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
