//
//  NotificationHandler.swift
//  perminder
//
//  Created by Leqi Shen on 2023-03-27.
//

import Foundation
import UserNotifications

class NotificationHandler:Identifiable {
    //There are no setters for title/body/date as it is assumed that they are set in Init and the notification is sent.
    private var reminderIdentifier: String //give name of reminder so that notification center can keep track of which ones are queued
    private var title: String
    private var body: String
    private var day: String //unused as of now - 
    private var time: String //4-number string to indicate military time
    private var isRead: Bool
    private var center: UNUserNotificationCenter
    
    init(Identifier:String, titleIn:String, bodyIn:String, dayIn:String, timeIn:String, centerIn:UNUserNotificationCenter) {
        reminderIdentifier = Identifier
        title = titleIn
        body = bodyIn
        day = dayIn
        time = timeIn
        isRead = false
        center = centerIn
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getBody() -> String {
        return body
    }
    
    public func getDay() -> String {
        return day
    }
    
    public func getTime() -> String {
        return time
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
        center.getNotificationSettings { Settings in
            switch Settings.authorizationStatus {
            case .authorized: isAllow = true; self.fireNotification()
            case .denied: isAllow = false
            case .notDetermined: self.center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Error requesting notification permission: \(error.localizedDescription)")
                    return
                }
                guard granted else {
                    print("User has denied notification permission")
                    return
                }
                isAllow = true; self.fireNotification()
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
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let hourString = time.dropLast(2)
        let hour = Int(hourString) ?? 0
        
        let minuteString = time.dropFirst(2)
        let minute = Int(minuteString) ?? 0
        
        var date = DateComponents()
        date.hour = hour
        date.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        // UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) //magic values 1 second and false repeat as placeholders
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        center.add(request)
    }
}

class CodableNotification:Codable {
    var reminderIdentifier: String //give name of reminder so that notification center can keep track of which ones are queued
    var title: String
    var body: String
    var day: String
    var time: String
    var isRead: Bool
}
