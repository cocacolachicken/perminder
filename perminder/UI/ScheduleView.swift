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
    @State var showHelp:Bool = false
    
    var body: some View {
        List { // Picks the type of schedule
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
            }
            
            switch currentType { // Switches between different pickers for different schedule
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
            
            switch currentType { // Shows an editor for the day picked
                case "daily":
                DayEditorView(daySelected:$dayPicked).environmentObject(dat)
                case "businessday":
                DayEditorView(daySelected:$dayPicked).environmentObject(dat)
                case "weekday":
                DayEditorView(daySelected:$dayPicked).environmentObject(dat)
                default:
                    EmptyView()
            }
        }.toolbar {
            Button("Help") {
                showHelp = true;
            }.alert(isPresented: $showHelp) {
                Alert(title: Text("Instructions"), message: Text("Select a type of schedule by using the drop down menu. Select the day on the schedule to go to its modifying page. Select an hour and a minute to add that time to the day. Notifications will appear on the times that you set."))
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
