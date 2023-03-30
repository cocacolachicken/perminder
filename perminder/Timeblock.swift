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
    
    
}

struct CodableTimeblock: Codable {
    var timeAssigned:String
    var groups:[CodableTag]
}
