//
//  Tag.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Tag:Identifiable {
    private var name:String
    private var reminders:[Reminder] = []
    private var color:RGB // Hex
    
    init (n:String, c:[Int]) {
        name = n
        color = RGB(red:c[0], green:c[1], blue:c[2])
    }
    
    init (n:String, c:[Int], r:[Reminder]) {
        name = n
        color = RGB(red:c[0], green:c[1], blue:c[2])
        reminders = r
    }
    
    func getColor () -> RGB {
        color
    }
    
    func setColor(colorSet:RGB) {
        color = colorSet
    }
    
    func getName () -> String {
        name
    }
    
    func setName(nameIn:String) {
        name = nameIn
    }
    
    func getReminders() -> [Reminder] {
        reminders
    }
    
    func addReminder (r:Reminder) {
        reminders.append(r)
    }
    
    #if DEBUG
    static let example = Tag(n:"Example", c:[255, 0, 0], r:[
        Reminder(n:"Test case", c:Date(), d:Date(), f:nil, tg:[Tag(n:"Example", c:[255, 0, 0])]),
        Reminder(n:"Test2", c:Date(), d:nil, f:nil, tg:[Tag(n:"Example", c:[255, 0, 0]), Tag(n:"Ex", c:[180, 180, 0])])
    ])
    #endif
}

class CodableTag: Codable {
    var name:String
    var color:[Int]
}
