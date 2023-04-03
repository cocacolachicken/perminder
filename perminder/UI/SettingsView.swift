//
//  SettingsVieiw.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @EnvironmentObject var dat:DataManager
    
    var body: some View {
        NavigationView {
            List {
                Section ("Scheduling") {
                    NavigationLink {
                        ScheduleView(currentType:dat.opt.sc.type).environmentObject(dat)
                    } label: {
                        Text("Set Schedule")
                    }
                }
                
                Section("Debugging") {
                    Button ("Send notification") {
                        let content = UNMutableNotificationContent()
                        content.title = "Test notification"
                        content.body = "testing !!!"
                        content.sound = UNNotificationSound.default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content:content, trigger:trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                    }
                }
            }.navigationTitle("Settings").navigationBarTitleDisplayMode(.large)
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    struct SVPreviewWrapper: View {
        @StateObject var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
        
        var body: some View {
            SettingsView().environmentObject(data)
        }
    }
    
    
    static var previews: some View {
        SVPreviewWrapper()
    }
}
#endif
