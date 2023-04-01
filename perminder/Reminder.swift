//
//  Reminder.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation


///Represents a reminder in the form of a struct
struct Reminder:Identifiable, Hashable {
    
    ///Method to comply with Identifiable and Hashable; Assumes true if the ids are equal
    static func == (lhs: Reminder, rhs: Reminder) -> Bool {
        lhs.rid == rhs.rid
    }
    
    ///Method to comply with Hashable; combines name and internal ID
    func hash (into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(rid)
    }
    
    private var name:String
    private static var nextID:Int = 0
    private var created:Date
    private var due:Date?
    private var finished:Date?
    var tags:[Tag] = [] // Public because it will mesh better with the UI
    var rid:Int
    
    ///To comply with Identifiable; internal ID is maked as "rid"
    var id:UUID =  UUID()
    
    ///Initializes a new reminder;
    ///
    /// - Parameters
    ///     - n: The name of the Reminder being created
    init (n:String) {
        name = n
        created = Date() // Sets date created to current date
        rid = Reminder.nextID // Sets ID to next ID
        Reminder.incrementID()
    }
    
    init (n:String, c:Date, d:Date?, f:Date?, tg:[Tag], i:Int) { // For use in test cases
        name = n
        created = c
        due = d
        finished = f
        tags = tg
        rid = i
    }
    
    /// Changes a CodableReminder into a Reminder
    ///
    /// - Parameters
    ///     - src: The reminder to be turned
    ///     - tagDatabase: The TagDatabase storing all information about tags
    init (_ src:CodableReminder, _ tagDatabase:TagDatabase) {
        name = src.name
        created = src.created
        due = src.due
        finished = src.finished
        rid = src.id
        for tag in src.tags {
            tags.append(tagDatabase[tag]!)
        }
    }
    
    public mutating func setName(nameSet:String) {
        name = nameSet
    }
    
    public func getName() -> String {
        return name
    }
    
    public mutating func changeName (str:String) {
        name = str
    }
    
    public func getCreated() -> Date {
        return created
    }
    
    public mutating func setDue(dueSet:Date) {
        due = dueSet
    }
    
    public mutating func markFinished () {
        finished = Date()
    }
    
    public mutating func markIncomplete () {
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

///Codable representation of a reminder; same attributes
class CodableReminder: Codable {
    
    ///Memberwise initializer to comply with Codable
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
    
    ///Converts from Reminder to CodableReminder
    init (r:Reminder) {
        name = r.getName()
        id = r.rid
        created = r.getCreated()
        due = r.getDue()
        finished = r.getFinished()
        
        for tag in r.getTags() {
            tags.append(tag.getName())
        }
    }
    
    
}
