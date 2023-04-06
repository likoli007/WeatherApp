//
//  ContentView.swift
//  WeatherApp
//
//  Created by Alojz on 2023/4/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            VStack {
                Text("CityName1")
                Text("Temperature")
                Text("weather type")
                Text("high/low")
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding().border(.blue)
            VStack {
                Text("AQI SHOW")
            }.padding().border(.green)
            VStack {
                Text("hourly forecast")
            }.padding().border(.green)
            VStack {
                Text("daily forecast")
            }.padding().border(.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


