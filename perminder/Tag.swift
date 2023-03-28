//
//  Tag.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Tag:Identifiable {
    private var name:String
    private var subject:String
    private var reminders:[Reminder] = []
    private var color:RGB // Hex
    
    init (n:String, s:String, c:[Int]) {
        name = n
        subject = s
        color = RGB(red:c[0], green:c[1], blue:c[2])
    }
    
#if DEBUG
    static let example = Tag(n:"Example", s:"Example", c:[255, 0, 0])
    #endif
}

class CodableTag: Codable {
    var name:String
    var subject:String
    var color:[Int]
}
