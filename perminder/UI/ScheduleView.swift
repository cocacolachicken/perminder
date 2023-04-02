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
                case "daily":
                    NavigationLink {
                        DayEditorView(daySelected:0).environmentObject(dat)
                    } label: {
                        Text("FOR THE !!!!")
                    }
                case "businessday":
                    ForEach (Array(dat.opt.sc.days.enumerated()), id:\.1.id) { index, day in
                        NavigationLink {
                            DayEditorView(daySelected:index).environmentObject(dat)
                        } label: {
                            Text()
                        }
                    }
                case "weekday":
                    ForEach (Array(dat.opt.sc.days.enumerated()), id:\.1.id) { index, day in
                        NavigationLink {
                            DayEditorView(daySelected:index).environmentObject(dat)
                        } label: {
                            
                        }
                    }
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
                    return "Sunday"
                case .Mo:
                    return "Monday"
                case .Tu:
                    return "Tuesday"
                case .We:
                    return "Wednesday"
                case .Th:
                    return "Thursday"
                case .Fr:
                    return "Friday"
                case .Sa:
                    return "Saturday"
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
