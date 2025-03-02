//
//  WelcomeView.swift
//  weather_app
//
//  Created by Viviana Tran on 3/1/25.
//


import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            VStack (spacing: 20) {
                Text("Welcome to YOUR weather app!")
                    .bold()
                    .font(.title)
                Text("Please share your location to get started!")
                    .padding()
            } .multilineTextAlignment(.center)
                .padding()
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(20)
                .symbolVariant(.fill)
                .foregroundColor(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
