//
//  WeatherManager.swift
//  weather_app
//
//  Created by Viviana Tran on 3/1/25.
//e56fbfd97cc4ef0bd13e5fc1fd256464

import Foundation
import CoreLocation
import WeatherKit

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://weatherkit.apple.com/api/v1/availability/\(latitude)/\(longitude)") else {
            fatalError("Missing URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: request)
        print(data)
        print(response)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}
struct ResponseBody: Decodable {
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
extension ResponseBody.MainResponse {
    var feelsLike: Double {
        return feels_like
    }
    var tempMin: Double {
        return temp_min
    }
    var tempMax: Double {
        return temp_max
    }
}
    


