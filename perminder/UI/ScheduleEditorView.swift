//
//  ScheduleModifierView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-01.
//

import SwiftUI

struct ScheduleEditorView: View {
    @Binding var sch:Schedule
    @Binding var dayPicked:Int
    
    var body: some View {
        
        VStack {
            if sch.type != "none" {
                if sch.type != "daily"{
                    Picker ("Day", selection:$dayPicked) {
                        ForEach (sch.days.indices, id:\.self) { ind in
                            Text(labels.getLabel(sch:sch, ind:ind)).tag(ind)
                        }
                    }.pickerStyle(.segmented)
                }
                
                DayEditorView(sch:$sch, ind:dayPicked)
            } else {
                Text("")
            }
            
        }
    }
    
    enum labels {
        enum businessday: Int {
            case Weekday = 0, Weekend
            
            var asString:String {
                switch self {
                case .Weekday:
                    return "Weekday"
                case .Weekend:
                    return "Weekend"
                }
            }
        }
        
        enum weekday:Int {
            case Su = 0, Mo, Tu, We, Th, Fr, Sa
            
            var asString:String {
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
        
        static func getLabel (sch:Schedule, ind:Int) -> String {
            switch sch.type {
            case "businessday":
                return businessday(rawValue:ind)!.asString
                
            case "weekday":
                return weekday(rawValue:ind)!.asString
            default:
                return ""
                
            }
        }
    }
}

#if DEBUG
struct ScheduleModifierView_Previews: PreviewProvider {
    struct SDV_Wrapper: View {
        @State var sc:Schedule = BusinessDay()
        @State var dayPicked:Int = 0
        
        var body: some View {
            ScheduleEditorView(sch:$sc, dayPicked:$dayPicked)
        }
    }
    
    static var previews: some View {
        HStack {
            List {
                SDV_Wrapper()
            }
        }
    }
}
#endif
