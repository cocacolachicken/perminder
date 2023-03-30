//
//  Day.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Day { // Represents a day composed of many timeblocks
    var times: [Timeblock] = []
    
    func getTimes () -> [Timeblock] {
        times
    }
    
    func deleteTime (index:Int) {
        times.remove(at:index)
    }
    
    func addTimeBlock (time:String) {
        times.append(Timeblock(tA:time))
    }
}

class CodableDay: Codable {
    var blocks: [[String]]
    var times: [String]
}
