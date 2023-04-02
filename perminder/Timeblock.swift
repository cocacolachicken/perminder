//
//  Timeblock.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

struct Timeblock: Identifiable, Hashable { // Represents a time (timeassigned) where a notification is wanted
    
    var timeAssigned:String
    var id = UUID()
    
    func hash (in hasher:inout Hasher) {
        hasher.combine(id)
    }
    
    init (tA:String) {
        timeAssigned = tA
    }
}

struct CodableTimeblock: Codable {
    init(time: String) {
        self.time = time
    }
    
    var time:String
    
    init (tbl:Timeblock) {
        time = tbl.timeAssigned
    }
}
