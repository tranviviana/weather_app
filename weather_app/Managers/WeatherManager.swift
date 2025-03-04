import Foundation
import WeatherKit
import CoreLocation

class WeatherManager:ObservableObject {
    // Define the function that returns current weather data asynchronously
    @available(iOS 16.0, *)
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentWeather? {
        let weatherService = WeatherService()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        @Published currentWeather
        
        do {
            let weatherData = try await weatherService.weather(for: location)
            let currentWeather = weatherData.currentWeather
            print("Weather data is available for this location.")
            return currentWeather
        } catch {
            print("Error fetching weather data: \(error.localizedDescription)")
            throw error
        }
    }
}
