//
//  ContentView.swift
//  WeatherApp
//
//  Created by Alojz on 2023/4/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            backgroundSunshine
            VStack{
                cityInformationTop
                cityAQI
                cityHourlyForecast
                cityDailyForecast
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var backgroundSunshine: some View{
    LinearGradient(colors: [.blue, .cyan],
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
    
}

var cityInformationTop: some View{
    VStack {
        Text("Bratislava").font(.system(size: 40, weight: .medium, design: .default))
        Text("21°").font(.system(size: 64, weight: .thin, design: .default))
        Text("Sunny").font(.system(size: 20, weight: .medium, design: .default))
        HStack{
            Text("H: 23°").font(.system(size: 20, weight: .medium, design: .default))
            Text("L: 16°").font(.system(size: 20, weight: .medium, design: .default))
        }
    }.padding().foregroundColor(.white)
}

var cityAQI: some View{
    VStack {
        HStack{
            Image(systemName: "aqi.low")
            Text("AIR QUALITY")
            Spacer()
        }
        Text("72 - Good").frame(maxWidth: .infinity, alignment: .leading)
        Text("Current AQI (CN) is 72").frame(maxWidth: .infinity, alignment: .leading)
        ZStack {
            Rectangle().fill(LinearGradient(colors:[.green,.green, .yellow, .red, .purple, .indigo, Color(red: 0.52, green: 0.0, blue: 0.125), Color(red: 0.52, green: 0.0, blue: 0.125), Color(red: 0.52, green: 0.0, blue: 0.125)], startPoint: .leading, endPoint: .trailing)).frame( height: 5)
            HStack{
                Spacer()
                Circle().strokeBorder(.black, lineWidth: 2).frame(width:8).background(Circle().foregroundColor(.white))
                Spacer()
                Spacer()
                Spacer()
            }
            
        }.frame(height:5)
    }.padding().foregroundColor(.white)
}

var cityHourlyForecast: some View{
    VStack{
        Text("Higher temperatures expected tomorrow, with a high of 28°")
        Divider()
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing:30){
                HourlyView(time: "Now", image: "sun.max.fill", temp: "21°")
                HourlyView(time: "15", image: "sun.max.fill", temp: "22°")
                HourlyView(time: "16", image: "cloud.sun.fill", temp: "20°")
                HourlyView(time: "17", image: "cloud.sun.fill", temp: "19°")
                HourlyView(time: "18", image: "cloud.rain.fill", temp: "17°")
                HourlyView(time: "19", image: "cloud.rain.fill", temp: "16°")
                HourlyView(time: "19:13", image: "sunset.fill", temp: "Sunset")
                HourlyView(time: "20", image: "cloud.rain.fill", temp: "16°")
                HourlyView(time: "21", image: "cloud.moon.fill", temp: "17°")
            }
            
        }
    }.padding(20).foregroundColor(.white)
}

var cityDailyForecast: some View{
    VStack {
        Text("daily forecast")
    }.padding().border(.green)
}



struct HourlyView: View {
    
    var time: String
    var image: String
    var temp: String
    
    
    var body: some View {
        VStack{
            Text(time)
            Image(systemName: image).renderingMode(.original)
            Text(temp)
        }
    }
}
