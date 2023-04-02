//
//  ScheduleEditorView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-04-01.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var sch:Schedule
    @State var type:String
    @State var m:String = "none"
    @State var dayPicked:Int = 0
    
    init (sch:Binding<Schedule>, type:String) {
        _sch = sch
        _type = .init(initialValue:type)
    }
    
    var body: some View {

        List {
            Picker ("Type", selection:$type) {
                Text("None").tag("none")
                Text("Daily").tag("daily")
                Text("Weekday/Weekend").tag("businessday")
                Text("Days of the Week").tag("weekday")
            }.onChange (of: type) { _ in
                dayPicked = 0
                
                switch type {
                case "none":
                    sch = NoSchedule()
                    return
                case "daily":
                    sch = Daily()
                    return
                case "businessday":
                    sch = BusinessDay()
                    return
                case "weekday":
                    sch = MTWTF()
                    return
                default:
                    return
                }
            }
            
            Section {
                switch type {
                    
                case "none":
                    VStack {
                        Text("Please choose a schedule type.")
                    }
                default:
                    ScheduleEditorView(sch:$sch, dayPicked:$dayPicked)
                }
            }
        }.navigationTitle("Set Schedule")
    }
}

#if DEBUG
struct ScheduleView_Previews: PreviewProvider {
    struct SVPreviewWrapper: View {
        @StateObject var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
        
        var body: some View {
            ScheduleView(sch:$data.opt.sc,
                               type: data.opt.sc.type)
        }
    }
    
    static var previews: some View {
        SVPreviewWrapper()
    }
}
#endif
