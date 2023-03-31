//
//  Timeblock.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

struct Timeblock { // Represents a time (timeassigned) where a notification is wanted
    var timeAssigned:String
    var groups:[String] = []
    
    init (tA:String) {
        timeAssigned = tA
    }
    
    init (tA:String, tags:[String]) {
        timeAssigned = tA
        for tag in tags {
            groups.append(tag)
        }
    }
    
    
}

struct CodableTimeblock: Codable {
    init(tags: [String] = [], time: String) {
        self.tags = tags
        self.time = time
    }
    
    var tags:[String] = []
    var time:String
    
    init (tbl:Timeblock) {
        time = tbl.timeAssigned
        for group in tbl.groups {
            tags.append(group)
        }
    }
}
