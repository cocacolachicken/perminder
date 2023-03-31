//
//  DataManager.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-25.
//

import Foundation

class DataManager: ObservableObject {
    @Published var tags:TagDatabase = TagDatabase()
    @Published var reminders:[Reminder] = []
    @Published var reminderByID:[Int:Reminder] = [:]
    @Published var completeness:[Int:Bool] = [:] //Note: This is here because only updates in structs will update the view
    @Published var opt:Options = Options()
    var src:CodableDataManager
    
    init (_ src: CodableDataManager) { // Gets DataManager from CodableDataManager
        self.src = src
        for tag in src.tags {
            tags.add(t:tag)
        }
        
        for reminder in src.reminders {
            reminders.append(Reminder(reminder, tags))
            for tag in reminders[reminders.count-1].getTags() {
                tag.addReminder(r:reminders[reminders.count-1])
            }
            
            reminderByID[reminder.id] = reminders[reminders.count-1]
            completeness[reminder.id] = reminder.finished != nil
        }
        
        Reminder.setID(id:src.currentTagID)
    }
    
    func initializeOptions () {
        opt = Options(src: src.options, tagDB: tags)
    }
    
    
    
    func markFinished (id: Int) {
        reminderByID[id]!.markFinished()
    }
    
    func markIncomplete (id: Int) {
        reminderByID[id]!.markIncomplete()
    }
}

class CodableDataManager: Codable {
    var tags:[CodableTag]
    var currentTagID:Int
    var reminders:[CodableReminder]
    var options:CodableOptions
}
