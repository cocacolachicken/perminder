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
    
    
    init (n:String) {
        name = n
        created = Date()
    }
}
