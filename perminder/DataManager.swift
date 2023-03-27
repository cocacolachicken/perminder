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
    
    init (_ src: CodableDataManager) {
        for tag in src.tags {
            tags.add(tag)
        }
        
        for reminder in src.reminders {
            reminders.append(Reminder())
        }
    }
}

class CodableDataManager: Codable {
    var tags:[CodableTag]
    var reminders:[CodableReminder]
}
