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
            ScrollView(.vertical, showsIndicators: false){
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
        }.foregroundColor(.gray)
        Text("72 - Good").frame(maxWidth: .infinity, alignment: .leading)
        Text("Current AQI (CN) is 72").frame(maxWidth: .infinity, alignment: .leading)
        ZStack {
            Rectangle().fill(LinearGradient(colors:[.green,.green, .yellow, .red, .purple, .indigo, Color(red: 0.52, green: 0.0, blue: 0.125), Color(red: 0.52, green: 0.0, blue: 0.125), Color(red: 0.52, green: 0.0, blue: 0.125)], startPoint: .leading, endPoint: .trailing)).frame( height: 6)
            HStack{
                Spacer()
                Circle().strokeBorder(.black, lineWidth: 2).frame(width:8).background(Circle().foregroundColor(.white))
                Spacer()
                Spacer()
                Spacer()
            }
            
        }.frame(height:8)
        Divider()
        Text("See More").frame(maxWidth: .infinity, alignment: .leading)
    }.padding().foregroundColor(.white)
}

var cityHourlyForecast: some View{
    VStack{
        Text("Higher temperatures expected tomorrow, with a high of 28°")
        Divider()
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing:30){
                HourlyView(time: "Now", image: "sun.max.fill", temp: "21°")
                HourlyView(time: "15", image: "sun.max.fill", temp: "23°")
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
        HStack{
            Image(systemName: "calendar")
            Text("10-DAY FORECAST")
            Spacer()
        }.foregroundColor(.gray)
        
        Group{
            DailyView(time: "Today", image: "cloud.rain.fill", temp1: 16, temp2: 23, today: true, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Mon", image: "cloud.rain.fill", temp1: 15, temp2: 20, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Tue", image: "sun.max.fill", temp1: 18, temp2: 24, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Wed", image: "cloud.sun.fill", temp1: 15, temp2: 22, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Thu", image: "cloud.rain.fill", temp1: 14, temp2: 17, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Fri", image: "sun.max.fill", temp1: 18, temp2: 23, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Sat", image: "sun.max.fill", temp1: 14, temp2: 23, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Sun", image: "cloud.sun.fill", temp1: 16, temp2: 23, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Mon", image: "cloud.fill", temp1: 15, temp2: 21, today: false, min: 14, max: 24, currtemp: 21.0)
            DailyView(time: "Tue", image: "cloud.bolt.rain.fill", temp1: 14, temp2: 16, today: false, min: 14, max: 24, currtemp: 21.0)
            
        }
    }.padding()
}

struct DailyView: View {
    
    
    var time: String
    var image: String
    var temp1: Int
    var temp2: Int
    var today: Bool
    var min: Int
    var max: Int
    @State var currtemp:Float
    
    
    var body: some View {
        HStack{
            Text(time).frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: image).renderingMode(.original).frame(maxWidth: .infinity, alignment: .leading)
            Text(String(temp1))
            
            ZStack {
                var size: Int = max - min;
                var start: Int = temp1 - min;
                var end: Int = max - temp2;
                var range: Int = temp2 - temp1;
                var step: Float = 70 / Float(size);

                var w: Float = 70 - (Float(size - range) * step);
                var half: Float = w / 2;
                
                Rectangle().fill(.gray).frame(width: 70, height: 6)
                Rectangle().fill(
                    LinearGradient(colors:[.cyan, .green, .yellow, .orange, .red], startPoint: .leading, endPoint: .trailing))
                .frame( width: CGFloat(w), height:6, alignment: .leading)
                .offset(x: -35 + CGFloat(half) + CGFloat(Float(start)*step))
                
            }.frame(width: 80, height:8, alignment: .leading)
            
            Text(String(temp2))
        }.foregroundColor(.white)
    }
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
