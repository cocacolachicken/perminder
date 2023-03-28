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
    
    init (_ src: CodableDataManager) { // Gets DataManager from CodableDataManager
        for tag in src.tags {
            tags.add(t:tag)
        }
        
        for reminder in src.reminders {
            reminders.append(Reminder(reminder, tags))
            for tag in reminders[reminders.count-1].getTags() {
                tag.addReminder(r:reminders[reminders.count-1])
            }
        }
    }
}

class CodableDataManager: Codable {
    var tags:[CodableTag]
    var reminders:[CodableReminder]
}
