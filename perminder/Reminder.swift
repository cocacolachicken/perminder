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
    private var due:Date?
    private var finished:Date?
    private var tags:[Tag] = []
    
    
    init (n:String) {
        name = n
        created = Date()
    }
    
    init (src:CodableReminder, tagDatabase:TagDatabase) {
        name = src.name
        created = src.created
        due = src.due
        finished = src.finished
        for tag in src.tags {
            tags.append(tagDatabase[tag])
        }
    }
}

class CodableReminder: Codable {
    var name:String
    var created:Date
    var due:Date?
    var finished:Date?
    var tags:[String]
}
