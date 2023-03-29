//
//  Reminder.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Reminder:Identifiable {
    private var name:String
    private var created:Date
    private var due:Date?
    private var finished:Date?
    private var tags:[Tag] = []
    
    
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
    
    // Used for decoding from JSON
    init (_ src:CodableReminder, _ tagDatabase:TagDatabase) {
        name = src.name
        created = src.created
        due = src.due
        finished = src.finished
        for tag in src.tags {
            tags.append(tagDatabase[tag])
        }
    }
    
    public func setName(nameSet:String) {
        name = nameSet
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getCreated() -> Date {
        return created
    }
    
    public func setDue(dueSet:Date) {
        due = dueSet
    }
    
    public func getDue() -> Date? {
        return due
    }
    
    public func isFinished() -> Bool {
        return (finished != nil)
    }
    
    public func getTags() -> [Tag] {
        tags
    }
    
    #if DEBUG
    static let example = Reminder(n:"Test case", c:Date(), d:Date(), f:nil, tg:[Tag(n:"test", c:[127, 255, 0]), Tag(n:"Test2", c:[127, 127, 255])])
    #endif
}

class CodableReminder: Codable {
    var name:String
    var created:Date
    var due:Date?
    var finished:Date?
    var tags:[String]
}
