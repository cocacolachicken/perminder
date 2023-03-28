//
//  Reminder.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Reminder: Identifiable {
    var name:String
    var created:Date
    var due:Date?
    var finished:Date?
    var tags:[Tag] = []
    
    
    init (n:String) {
        name = n
        created = Date()
    }
    
    init (n:String, c:Date, d:Date?, f:Date?, tg:[Tag]) {
        name = n
        created = c
        due = d
        finished = f
        tags = tg
    }
    
    init (_ src:CodableReminder, _ tagDatabase:TagDatabase) {
        name = src.name
        created = src.created
        due = src.due
        finished = src.finished
        for tag in src.tags {
            tags.append(tagDatabase[tag])
        }
    }
    
    func setName(nameSet:String) {
        name = nameSet
    }
    
    func getName() -> String {
        return name
    }
    
    func getCreated() -> Date {
        return created
    }
    
    func setDue(dueSet:Date) {
        due = dueSet
    }
    
    func getDue() -> Date? {
        return due
    }
    
    func isFinished() -> Bool {
        return (finished != nil)
    }
    
    #if DEBUG
    static let example = Reminder(n:"Test case", c:Date(), d:nil, f:nil, tg:[Tag(n:"test", c:[127, 255, 0]), Tag(n:"Test2", c:[127, 127, 255])])
    #endif
}

class CodableReminder: Codable {
    var name:String
    var created:Date
    var due:Date?
    var finished:Date?
    var tags:[String]
}
