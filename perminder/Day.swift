//
//  Day.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Day { // Represents a day composed of many timeblocks
    var blocks: [String:Timeblock] = [:] // Time:Timeblock
    var times: [String] = []
    
    subscript (index:String) -> Timeblock? {
        get {
            blocks[index]
        }
        
        set {
            blocks[index] = newValue
        }
    }
}

class CodableDay: Codable {
    var blocks: [String:[String]]
}
