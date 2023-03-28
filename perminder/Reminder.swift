//
//  Reminder.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Reminder {
    private var name:String
    private var created:Date
    private var due:Date
    private var finished:Date?

    
    init (nameIn:String, createdIn:Date, dueIn:Date, finishedIn:Date? = nil) {
        name = nameIn
        created = createdIn
        due = dueIn
        finished = finishedIn
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
    
    public func setDue(dueSet : Date) {
        due = dueSet
    }
    
    public func getDue() -> Date {
        return due
    }
}
