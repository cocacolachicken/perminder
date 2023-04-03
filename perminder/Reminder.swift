//
//  Reminder.swift
//  perminder
//  A simple reminder, containing all the parameters of its creation time, due date, finished date, name, etc. as well as any tags that are assigned.
//
//  Created by Tyler Gu and Leqi Shen on 2023-03-21.
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
    public var isFinished:Bool {
        get {
            finished != nil
        }
        set {
            if newValue == false {
                finished = nil
            } else {
                finished = Date()
            }
        }
    }
    var tags:[String] = [] // Public because it will mesh better with the UI
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
    
    init (n:String, c:Date, d:Date?, f:Date?, tg:[String], i:Int) { // For use in test cases to control each element
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
            tags.append(tagDatabase[tag]!.getName())
        }
    }
    
    //getters and setters
    /**
     * sets the name
     * @param nameSet the new name to be set
     */
    public mutating func setName(nameSet:String) {
        name = nameSet
    }
    
    /**
     * gets the name
     * @return the name
     */
    public func getName() -> String {
        return name
    }
    
    /**
     * Essentially the same as setName
     * @param str the new name
     */
    public mutating func changeName (str:String) {
        name = str
    }
    
    /**
     * gets the time created for the reminder
     * @return the Date value for when the object is created
     */
    public func getCreated() -> Date {
        return created
    }
    
    /**
     * Sets the due date with a date passed in
     * @param dueSet the due date to be set
     */
    public mutating func setDue(dueSet:Date?) {
        due = dueSet
    }
    
    /**
     * Marks the reminder as finished by adding the current date
     */
    public mutating func markFinished () {
        finished = Date()
    }
    
    /**
     * Marks the reminder as imcomplete by erasing the finished date
     */
    public mutating func markIncomplete () {
        finished = nil
    }
    
    /**
     * gets the finished date, if it is finished
     * @return a Date value signifying the finished time
     */
    public func getFinished () -> Date? {
        finished
    }
    
    /**
     * gets the due date, if it is set
     * @return a Date value signifying the due date
     */
    public func getDue() -> Date? {
        return due
    }
    
    /**
     * gets the tags given to the reminder
     * @return a string array of all the tags
     */
    public func getTags() -> [String] {
        tags
    }
    
    /**
     * increments the next ID by 1
     */
    public static func incrementID() {
        nextID += 1
    }
    
    /**
     * sets the next ID
     * @param id: the int to set the next ID to be given
     */
    public static func setID (id:Int) {
        nextID = id
    }
    
    /**
     * gives the next ID
     * @return next ID
     */
    public static func getNextID () -> Int {
        nextID
    }
    
    #if DEBUG
    static let example = Reminder(n:"Test case", c:Date(), d:Date(), f:nil, tg:["test", "test"], i:0)
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
            tags.append(tag)
        }
    }
    
    
}
