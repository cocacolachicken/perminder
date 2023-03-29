//
//  Notification.swift
//  perminder
//
//  Created by Leqi Shen on 2023-03-27.
//

import Foundation
import UserNotifications

class Notification:Identifiable {
    //There are no setters for title/body/date as it is assumed that they are set in Init and the notification is sent.
    private var title: String
    private var body: String
    private var date: Date
    private var isRead: Bool
    
    
    init(titleIn:String, bodyIn:String, dateIn:Date, isReadIn:Bool=false) {
        title = titleIn
        body = bodyIn
        date = dateIn
        isRead = isReadIn
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getBody() -> String {
        return body
    }
    
    public func getDate() -> Date {
        return date
    }
    
    public func markAsRead() {
        isRead = true
    }
    
    public func markUnRead() {
        isRead = false
    }
    
    public func isUnread() -> Bool {
        return !isRead
    }
    
    /**
     * Just asks permission and does nothing else.
     */
    public func requestPermission() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if granted {
                //can add stuff for if permission granted
            }
        }
    }
    
    /**
     * This is the method to be used when you want to send a notification
     * checks for permission. If granted, gives notif and returns true, if not, returns false
     * True return can be ignored if fired, but if it returns false there can be additional logic checks if needed. Also fine if nothing is done with return,
     * basically for debugging at this stage and can be removed later
     *
     * @Return true if the notification is given permission to be fired, false if not
     */
    public func checkPermission() -> Bool {
        var isAllow = false
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { Settings in
            switch Settings.authorizationStatus {
            case .authorized: isAllow = true; self.fireNotification()
            case .denied: isAllow = false
            case .notDetermined: center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        isAllow = true
                        self.fireNotification()
                    }
                }
            case .ephemeral: isAllow = true; self.fireNotification()
            case .provisional: isAllow = true; self.fireNotification()
            }
        }
        return isAllow
    }
    
    /**
     * gives a notification with title, body, and the default apple notification sound. Is used in checkPermission.
     */
    public func fireNotification() {
        let identifier = "test-notification"
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) //magic values 1 second and false repeat as placeholders
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        center.add(request)
    }
}

class CodableNotification:Codable {
    var title: String
    var body: String
    var date: Date
    var isRead: Bool
}
