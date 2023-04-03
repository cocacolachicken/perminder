//
//  perminderApp.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI
import UserNotifications

@main
struct perminderApp: App {
    var codedData:CodableDataManager?
    @StateObject var dat:DataManager = DataManager() // If you want to use the canvas previews in the UI files, please comment out lines 1e and 17-20 (inclusive)
    
    init () {
        codedData = readFromJSONFile(fileName:"sav.json")
        let decodedData = codedData != nil ? DataManager(codedData!) : DataManager()
        _dat = .init(wrappedValue: decodedData)
        setNotifications(data:dat)
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dat)
        }
    }
    
    
}


func setNotifications (data:DataManager) {
    var condition:Bool = true
    
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        switch settings.authorizationStatus {
        case .authorized: condition = true; print("allowed"); break;
        case .denied: condition = false; break;
        case .notDetermined:
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                
                if granted {
                    condition = true
                    print("allowed")
                } else {
                    print("not allowed")
                    
                }
            }
            break;
        case .ephemeral: condition = true; print("allowed"); break;
        case .provisional: condition = true; print("allowed"); break;
        }
    }
    
    print(data.opt.sc.type)
    print(String(condition))
    
    
    if (data.opt.sc.type != "none" && condition) {
        print("loading notifications...")
        
        let formatter = DateFormatter()
        let timeRightNow = Date()
        
        formatter.dateFormat = "HH"
        let currentHour = Int(formatter.string(from:timeRightNow))!
        
        formatter.dateFormat = "mm"
        let currentMinute = Int(formatter.string(from:timeRightNow))!
        
        formatter.dateFormat = "EEEE"
        var index = 0
        
        for time in data.opt.sc[formatter.string(from:Date())].times {
            let content = UNMutableNotificationContent()
            content.title = "Perminder is calling to you~"
            content.body = "Check on your perminders!"
            content.sound = UNNotificationSound.default
            
            var date = DateComponents()
            
            
            let houroff = time.timeAssigned.index(time.timeAssigned.startIndex, offsetBy:1)
            date.hour = Int(time.timeAssigned[...houroff])!
            let minuteoff = time.timeAssigned.index(time.timeAssigned.startIndex, offsetBy:2)
            date.minute = Int(time.timeAssigned[minuteoff...])!
            
            let minuteOffset = date.minute! - currentMinute
            let hourOffset = date.hour! - currentHour
            let totalOffset = minuteOffset * 60 + hourOffset * 60 * 60
            if totalOffset > 0 {
            
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval:TimeInterval(totalOffset), repeats:false)
               
                let request = UNNotificationRequest(identifier: String(index) + time.timeAssigned, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}
