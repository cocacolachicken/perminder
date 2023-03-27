//
//  Tag.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Tag {
    var name:String
    var reminders:[Reminder] = []
    
    init (n:String) {
        name = n
    }
    
    
}

class CodableTag: Codable {
    var name:String
}
