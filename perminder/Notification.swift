//
//  Notification.swift
//  perminder
//
//  Created by Leqi Shen on 2023-03-27.
//

import Foundation
import UserNotifications

class Notification {
    //There are no setters for title/body/date as it is assumed that they are set in Init and the notification is sent.
    private var title: String
    private var body: String
    private var date: Date
    private var isRead: Bool
    
    let center = UNUserNotificationCenter.current()
    
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
    
    public func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                
            }
            
            // Enable or disable features based on the authorization.
        }
    }
    
    public func fireNotification() {
        
    }
}

class CodableNotification:Codable {
    var title: String
    var body: String
    var date: Date
    var isRead: Bool
}
