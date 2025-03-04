import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherManager = WeatherManager()
    @State private var isWeatherLoading = false
    
    var body: some View {
        VStack {
            // Ensure we have location data
            if let location = locationManager.location {
                // Check if iOS 16.0 or higher is available
                if #available(iOS 16.0, *) {
                    
                    if let _ = $weatherManager.currentWeather {
                        Text("Weather data fetched successfully!")
                    } else {
                        LoadingView()
                            .task {
                                // Fetch the weather data asynchronously
                                do {
                                    try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                } catch {
                                    // Handle any errors that occur while fetching weather
                                    print("Error fetching weather data: \(error)")
                                }
                            }
                    }
                } else {
                    Text("Weather data is not available on this version.")
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354)) // Background color
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
