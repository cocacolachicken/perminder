//
//  DataManager.swift
//  perminder
//
//  Created by Tyler Gu and Leqi Shen on 2023-03-25.
//

import Foundation

class DataManager: ObservableObject {
    @Published var tags:TagDatabase = TagDatabase()
    @Published var reminders:[Reminder] = []
    @Published var opt:Options = Options()
    var src:CodableDataManager
    
    init (_ src: CodableDataManager) { // Gets DataManager from CodableDataManager
        self.src = src
        for tag in src.tags {
            tags.add(t:tag)
        }
        
        for reminder in src.reminders {
            reminders.append(Reminder(reminder, tags))
        }
        
        Reminder.setID(id:src.currentTagID)
        opt = Options(src: src.options)
    }
    
    init () {
        src = CodableDataManager()
    }
    
    func markFinished (index: Int) {
        reminders[index].markFinished()
    }
    
    func markIncomplete (index: Int) {
        reminders[index].markIncomplete()
    }
    
    func getCodableVersion () -> CodableDataManager {
        return CodableDataManager(tags: tags.tagsAsAnArray, reminders:reminders, options:opt)
    }
    
    func addReminder (n:String) {
        reminders.append(Reminder(n:n))
    }
    
    /**
     * finds all reminders with the same tag name
     * @param tagIn the tag passed in to search
     * @return an array of all the indicies of the reminders with the specified tag
     */
    func findAllReminders(tagIn:String) -> [Int]{
        var reminderIndex:Int = 0
        var indices:[Int] = []
        for reminder in reminders {
            for tag in reminder.tags where tag == tagIn {
                indices.append(reminderIndex)
            }
            reminderIndex += 1
        }
        return indices
    }
}

class CodableDataManager: Codable {
    init(tags: [CodableTag] = [], currentTagID: Int, reminders: [CodableReminder] = [], options: CodableOptions) {
        self.tags = tags
        self.currentTagID = currentTagID
        self.reminders = reminders
        self.options = options
    }
    
    var tags:[CodableTag] = []
    var currentTagID:Int
    var reminders:[CodableReminder] = []
    var options:CodableOptions
    
    init (tags uTags:[Tag], reminders uReminders:[Reminder], options uOptions:Options) {
        currentTagID = Reminder.getNextID()
        for tag in uTags {
            tags.append(CodableTag(t:tag))
        }
        
        for reminder in uReminders {
            reminders.append(CodableReminder(r:reminder))
        }
        
        options = CodableOptions (opt:uOptions)
        
    }
    
    init () {
        currentTagID = 0
        options = CodableOptions()
    }
}
