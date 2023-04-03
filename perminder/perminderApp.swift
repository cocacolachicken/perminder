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
    @StateObject var dat:DataManager
    var center:UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    init () {
        codedData = readFromJSONFile(fileName:"sav.json")
        let decodedData = codedData != nil ? DataManager(codedData!) : DataManager()
        _dat = .init(wrappedValue: decodedData)
        setNotifications(dat:dat)
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dat)
        }
    }
    
    func setNotifications (data:DataManager) {
        
        let _:NotificationHandler = NotificationHandler(Identifier: "", titleIn: "Perminder time!", bodyIn: "Please come and check on your reminders.", dayIn: "", timeIn: "0000", centerIn: center)
        
        
        if (data.opt.sc.type != "none") {
            print("loading notifications...")
            
            let formatter = DateFormatter()
            
            formatter.dateFormat = "EEEE"
            
            for time in data.opt.sc[formatter.string(from:Date())].times {
                let handler:NotificationHandler = NotificationHandler(Identifier: time.timeAssigned, titleIn: "Perminder time!", bodyIn: "Please come and check on your reminders.", dayIn: "", timeIn: time.timeAssigned, centerIn: center)
                if handler.checkPermission() {
                    print("Success")
                } else {
                    print ("Doesn't work...")
                }
            }
        }
    }
}


