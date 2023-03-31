//
//  Timeblock.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

struct Timeblock { // Represents a time (timeassigned) where a notification is wanted
    var timeAssigned:String
    var groups:[Tag] = []
    
    init (tA:String) {
        timeAssigned = tA
    }
    
    init (tA:String, tags:[String], tagDB:TagDatabase) {
        timeAssigned = tA
        for tag in tags {
            groups.append(tagDB[tag])
        }
    }
    
    
}

struct CodableTimeblock: Codable {
    var tags:[String]
    var time:String
}
