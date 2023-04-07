//
//  ContentView.swift
//  WeatherApp
//
//  Created by Alojz on 2023/4/4.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State var tick = false
    
    //let animation: Animation = Animation.linear(duration:10.0).repeatForever(autoreverses: false)
    
    let img: Image = Image("Daco_4555830").resizable()
    let img2: Image = Image("Daco_4318142").resizable()
    
    @State var ofs1: Int = -30;
    @State var ofs2: Int = 50;
    
    var body: some View {
        ZStack{
            backgroundSunshine
            
            ZStack {
                img.offset(x: CGFloat(ofs1), y: -300)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200.0, height: 300, alignment: .trailing)
                    .onReceive(timer){_ in
                        ofs1 = ofs1-1
                        if ofs1 < -275{
                            ofs1 = 650
                        }
                    }.ignoresSafeArea()
                img2.offset(x: CGFloat(ofs2), y: -300)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200.0, height: 300, alignment: .leading)
                    .onReceive(timer){_ in
                        ofs2 = ofs2-1
                        if ofs2 < -640{
                            ofs2 = 290
                        }
                    }.ignoresSafeArea()
            }.frame(alignment: .trailing)
            
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    cityInformationTop
                    cityAQI.padding(.bottom, 5)
                    cityHourlyForecast
                    cityDailyForecast
                    UVIndex
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
    ZStack{
        LinearGradient(colors: [.blue, .cyan],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
        
    }
}

var cityInformationTop: some View{
    VStack {
        Text("Bratislava").shadow(radius: 5.0).font(.system(size: 40, weight: .medium, design: .default))
        Text("21°").shadow(radius: 5.0).font(.system(size: 64, weight: .thin, design: .default))
        Text("Cloudy").shadow(radius: 5.0).font(.system(size: 20, weight: .medium, design: .default))
        HStack{
            Text("H: 23°").font(.system(size: 20, weight: .medium, design: .default))
            Text("L: 16°").font(.system(size: 20, weight: .medium, design: .default))
        }.shadow(radius: 5.0)
    }.padding().foregroundColor(.white)
}

var cityAQI: some View{
    VStack {
        HStack{
            Image(systemName: "aqi.low").resizable().frame(width: 15, height:15)
            Text("AIR QUALITY").font(.system(size: 12, weight: .medium, design: .default))
            Spacer()
        }.foregroundColor(.white.opacity(0.6)).padding(.vertical, 5).frame(height:10)
        Text("72 - Good").shadow(radius: 5.0).font(.system(size: 18, weight: .medium, design: .default)).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 3)
        Text("Current AQI (CN) is 72.").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 14, weight: .light, design: .default))
        ZStack {
            Rectangle().fill(LinearGradient(colors:[.green,.green, .yellow, .red, .purple, .indigo, Color(red: 0.52, green: 0.0, blue: 0.125), Color(red: 0.52, green: 0.0, blue: 0.125), Color(red: 0.52, green: 0.0, blue: 0.125)], startPoint: .leading, endPoint: .trailing)).frame( height: 6)
            HStack{
                Spacer()
                Circle().strokeBorder(.teal.opacity(0.8), lineWidth: 2).frame(width:8).background(Circle().foregroundColor(.white))
                Spacer()
                Spacer()
                Spacer()
            }
            
        }.frame(height:8)
        Divider()
        HStack{
            Text("See More").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 16, weight: .medium, design: .default))
            Spacer()
            Image(systemName: "chevron.right")
        }
    }.padding().foregroundColor(.white).frame(width:350).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
}

var cityHourlyForecast: some View{
    VStack{
        Text("Higher temperatures expected tomorrow, with a high of 28°").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 14, weight: .light, design: .default))
        Divider()
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing:25){
                Group{
                    HourlyView(time: "Now", image: "cloud.sun.fill", temp: "21°")
                    HourlyView(time: "15", image: "sun.max.fill", temp: "23°")
                    HourlyView(time: "16", image: "cloud.sun.fill", temp: "20°")
                    HourlyView(time: "17", image: "cloud.sun.fill", temp: "19°")
                    HourlyView(time: "18", image: "cloud.rain.fill", temp: "17°")
                    HourlyView(time: "19", image: "cloud.rain.fill", temp: "16°")
                    HourlyView(time: "19:13", image: "sunset.fill", temp: "Sunset")
                    HourlyView(time: "20", image: "cloud.rain.fill", temp: "16°")
                    HourlyView(time: "21", image: "cloud.moon.fill", temp: "17°")
                    HourlyView(time: "22", image: "cloud.moon.fill", temp: "16°")
                }
                Group{
                    HourlyView(time: "23", image: "moon.fill", temp: "16°")
                    HourlyView(time: "00", image: "moon.fill", temp: "16°")
                    HourlyView(time: "01", image: "cloud.moon.fill", temp: "17°")
                    HourlyView(time: "02", image: "moon.fill", temp: "18°")
                    HourlyView(time: "03", image: "cloud.moon.fill", temp: "20°")
                    HourlyView(time: "04", image: "cloud.moon.fill", temp: "21°")
                    HourlyView(time: "05", image: "moon.fill", temp: "20°")
                    HourlyView(time: "05:46", image: "sunrise.fill", temp: "Sunrise")
                    HourlyView(time: "06", image: "sun.max.fill", temp: "20°")
                    HourlyView(time: "07", image: "cloud.sun.fill", temp: "20°")
                    
                }
                Group{
                    HourlyView(time: "08", image: "sun.max.fill", temp: "19°")
                    HourlyView(time: "09", image: "sun.max.fill", temp: "20°")
                    HourlyView(time: "10", image: "sun.max.fill", temp: "18°")
                    HourlyView(time: "11", image: "cloud.sun.fill", temp: "17°")
                    HourlyView(time: "12", image: "cloud.rain.fill", temp: "16°")
                    HourlyView(time: "13", image: "cloud.rain.fill", temp: "15°")
                    HourlyView(time: "14", image: "cloud.sun.fill", temp: "17°")
                }
            }
            
        }
    }.padding().foregroundColor(.white).frame(width: 350).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
}

var UVIndex: some View{
    VStack{
        HStack{
            Image(systemName: "sun.max.fill")
            Text("UV INDEX")
        }
        Text("9")
        Text("Very High")
        ZStack{
            Rectangle().fill(LinearGradient(colors:[.green,.green, .yellow, .red, .purple], startPoint: .leading, endPoint: .trailing)).frame( height: 6)
            Circle().strokeBorder(.black, lineWidth: 2).frame(width:8).background(Circle().foregroundColor(.white)).offset(x:30)
        }
        Text("Use sun protection until 17:00")
        
    }.padding(20).foregroundColor(.white)
}




var cityDailyForecast: some View{
    VStack {
        HStack{
            Image(systemName: "calendar").font(.system(size:15))//.frame(width:30, height:30, alignment: .center))//.resizable().frame(width: 15, height:15)
            Text("10-DAY FORECAST").font(.system(size: 12, weight: .medium, design: .default)).frame(height:30)
            Spacer()
        }.foregroundColor(.white.opacity(0.6)).padding(.vertical, 5).frame(height:10)
        
        Group{
            Divider()
            DailyView(time: "Today", image: "cloud.rain.fill", temp1: 16, temp2: 23, today: true, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Mon", image: "cloud.rain.fill", temp1: 15, temp2: 20, today: false, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Tue", image: "sun.max.fill", temp1: 18, temp2: 24, today: false, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Wed", image: "cloud.sun.fill", temp1: 15, temp2: 22, today: false, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Thu", image: "cloud.rain.fill", temp1: 14, temp2: 17, today: false, min: 14, max: 24, currtemp: 21.0)
        }
        Group{
            Divider()
            DailyView(time: "Fri", image: "sun.max.fill", temp1: 18, temp2: 23, today: false, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Sat", image: "sun.max.fill", temp1: 14, temp2: 23, today: false, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Sun", image: "cloud.sun.fill", temp1: 16, temp2: 23, today: false, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Mon", image: "cloud.fill", temp1: 15, temp2: 21, today: false, min: 14, max: 24, currtemp: 21.0)
            Divider()
            DailyView(time: "Tue", image: "cloud.bolt.rain.fill", temp1: 14, temp2: 16, today: false, min: 14, max: 24, currtemp: 21.0)
            
        }
    }.padding().frame(width:350).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
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
                let size: Int = max - min;
                let start: Int = temp1 - min;
                let range: Int = temp2 - temp1;
                let step: Float = 70 / Float(size);

                let w: Float = 70 - (Float(size - range) * step);
                let half: Float = w / 2;
                
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
            Text(time).padding(.bottom, 3).font(.system(size: 14, weight: .medium, design: .default))
            Image(systemName: image).renderingMode(.original).font(.system(size:20)).frame(width:30, height:30)//.border(.red)//.resizable().scaledToFit().frame(width: 30, height:30)
            Text(temp).padding(.top, 3).font(.system(size: 16, weight: .bold, design: .default))
        }.padding(.top, 10)
    }
}

