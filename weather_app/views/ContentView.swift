//
//  ContentView.swift
//  weather_app
//
//  Created by Viviana Tran on 3/1/25.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    @State var locationManager =  LocationManager()
    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
            } else {
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
