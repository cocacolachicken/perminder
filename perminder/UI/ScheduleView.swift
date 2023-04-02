//
//  ScheduleView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-02.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var dat:DataManager
    @State var currentType:String = "none"
    @State var dayPicked:Int = 0
    
    var body: some View {
        List {
            Picker ("Type of Schedule", selection:$currentType) {
                Text("None").tag("none")
                Text("Daily").tag("daily")
                Text("Business Day").tag("businessday")
                Text("S/M/T/W/T/F/S").tag("weekday")
            }.onChange(of:currentType) { newVal in
                dayPicked = 0
                
                switch newVal {
                case "daily":
                    dat.opt.sc = Daily()
                    break;
                case "businessday":
                    dat.opt.sc = BusinessDay()
                    break;
                case "weekday":
                    dat.opt.sc = MTWTF()
                    break;
                default:
                    dat.opt.sc = NoSchedule()
                    break;
                }
                
                dat.objectWillChange.send()
            }
            
            switch currentType {
                case "businessday":
                    Picker ("Day", selection:$dayPicked) {
                        ForEach (0...1, id:\.self) { ind in
                            Text(Labels.BSSDay(rawValue: ind)!.label).tag(ind)
                        }
                    }.pickerStyle(.segmented)
                case "weekday":
                    Picker ("Day", selection:$dayPicked) {
                        ForEach (0...6, id:\.self) { ind in
                            Text(Labels.MTWTF(rawValue: ind)!.label).tag(ind)
                        }
                    }.pickerStyle(.segmented)
                default:
                    EmptyView()
                    
            }
            
            switch currentType {
                case "daily":
                DayEditorView(daySelected:$dayPicked).environmentObject(dat)
                case "businessday":
                DayEditorView(daySelected:$dayPicked).environmentObject(dat)
                case "weekday":
                DayEditorView(daySelected:$dayPicked).environmentObject(dat)
                default:
                    EmptyView()
            }
        }
    }
    
    enum Labels {
        enum BSSDay: Int {
            case Weekend = 0, Weekday
            
            var label:String {
                switch self {
                case .Weekday:
                    return "Weekday"
                case .Weekend:
                    return "Weekend"
                }
            }
        }
        
        enum MTWTF: Int {
            case Su = 0, Mo, Tu, We, Th, Fr, Sa
            
            var label:String {
                switch self {
                case .Su:
                    return "Su"
                case .Mo:
                    return "Mo"
                case .Tu:
                    return "Tu"
                case .We:
                    return "We"
                case .Th:
                    return "Th"
                case .Fr:
                    return "Fr"
                case .Sa:
                    return "Sa"
                }
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    struct SV_Wrapper: View {
        @StateObject var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
        
        var body: some View {
            NavigationView {
                ScheduleView(currentType:data.opt.sc.type).environmentObject(data)
                
            }
        }
    }
    
    static var previews: some View {
        SV_Wrapper()
    }
}
