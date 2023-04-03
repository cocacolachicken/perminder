//
//  TimeSelector.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-02.
//

import SwiftUI

struct TimeSelector: View {
    @Binding var time:String
    @State var hour:Int
    @State var minute:Int
    
    init (time:String, bind:Binding<String>) {
        let houroff = time.index(time.startIndex, offsetBy:1)
        _hour = .init(initialValue:Int(time[...houroff])!)
        
        let minuteoff = time.index(time.startIndex, offsetBy:2)
        _minute = .init(initialValue:Int(time[minuteoff...])!)
        
        
        _time = bind
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker ( // Picks an hour
                    "Hour",
                    selection: $hour
                ) {
                    ForEach (0...23, id:\.self) { h in
                        Text(String(h)).tag(h)
                    }
                }.onChange(of: hour, perform: { _ in
                    time = String(format: "%02d", hour) + String(format: "%02d", minute)
                }).pickerStyle(.menu)
                
                Picker ( // Picks a minute
                    "Minute",
                    selection: $minute
                ) {
                    ForEach (0...59, id:\.self) { m in
                        Text(String(m)).tag(m)
                    }
                }.onChange(of: minute, perform: { _ in
                    time = String(format: "%02d", hour) + String(format: "%02d", minute)
                }).pickerStyle(.menu)
                
                Spacer()
            }
            
        }
    }
}

struct TimeSelector_Previews: PreviewProvider {
    struct TS_Wrapper: View {
        @State var time:String = "1234"
        
        var body: some View {
            TimeSelector(time: time, bind: $time)
        }
    }
    
    static var previews: some View {
        TS_Wrapper()
    }
}
