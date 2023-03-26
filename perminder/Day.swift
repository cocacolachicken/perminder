//
//  Day.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Day {
    var blocks: [String:Timeblock] = [:] // Time:Timeblock
    
    subscript (index:String) -> Timeblock? {
        get {
            blocks[index]
        }
        
        set {
            blocks[index] = newValue
        }
    }
}
