//
//  Reminder.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Reminder:Identifiable, Hashable {
    static func == (lhs: Reminder, rhs: Reminder) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash (into hasher: inout Hasher) {
        hasher.combine( ObjectIdentifier(self).hashValue)
    }
    
    private var name:String
    private static var nextID:Int = 0
    private var created:Date
    private var due:Date?
    private var finished:Date?
    private var tags:[Tag] = []
    var id:Int
    
    
    init (n:String) {
        name = n
        created = Date()
        id = Reminder.nextID
        Reminder.incrementID()
    }
    
    init (n:String, c:Date, d:Date?, f:Date?, tg:[Tag], i:Int) {
        name = n
        created = c
        due = d
        finished = f
        tags = tg
        id = i
    }
    
    // Used for decoding from JSON
    init (_ src:CodableReminder, _ tagDatabase:TagDatabase) {
        name = src.name
        created = src.created
        due = src.due
        finished = src.finished
        id = src.id
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
    
    public func changeName (str:String) {
        name = str
    }
    
    public func getCreated() -> Date {
        return created
    }
    
    public func setDue(dueSet:Date) {
        due = dueSet
    }
    
    public func markFinished () {
        finished = Date()
    }
    
    public func markIncomplete () {
        finished = nil
    }
    
    public func getFinished () -> Date? {
        finished
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
    
    public static func incrementID() {
        nextID += 1
    }
    
    public static func setID (id:Int) {
        nextID = id
    }
    
    public static func getNextID () -> Int {
        nextID
    }
    
    #if DEBUG
    static let example = Reminder(n:"Test case", c:Date(), d:Date(), f:nil, tg:[Tag(n:"test", c:[127, 255, 0]), Tag(n:"Test2", c:[127, 127, 255])], i:0)
    #endif
}

class CodableReminder: Codable {
    init(name: String, id: Int, created: Date, due: Date? = nil, finished: Date? = nil, tags: [String] = []) {
        self.name = name
        self.id = id
        self.created = created
        self.due = due
        self.finished = finished
        self.tags = tags
    }
    
    var name:String
    var id:Int
    var created:Date
    var due:Date?
    var finished:Date?
    var tags:[String] = []
    
    init (r:Reminder) {
        name = r.getName()
        id = r.id
        created = r.getCreated()
        due = r.getDue()
        finished = r.getFinished()
        
        for tag in r.getTags() {
            tags.append(tag.getName())
        }
    }
    
    
}
