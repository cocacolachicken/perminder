//
//  Day.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

struct Day {
    var blocks: [String:Timeblock] = [:] // Time:Timeblock
    
    subscript (index:String) -> Timeblock? {
        blocks[index]
    }
}
