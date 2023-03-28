//
//  Tag.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Tag:Identifiable {
    var name:String
    var reminders:[Reminder] = []
    var color:RGB // Hex
    
    init (n:String, c:[Int]) {
        name = n
        color = RGB(red:c[0], green:c[1], blue:c[2])
    }
}

class CodableTag: Codable {
    var name:String
    var color:[Int]
}
