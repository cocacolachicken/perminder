//
//  Tag.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class Tag:Identifiable, Hashable {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
    
    func hash (into hasher:inout Hasher) {
        hasher.combine(name)
        hasher.combine(color)
    }
    
    private var name:String
    private var color:RGB
    var id = UUID()
    
    init (n:String, c:[Int]) {
        name = n
        color = RGB(red:c[0], green:c[1], blue:c[2])
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
    
    #if DEBUG
    static let example = Tag(n:"Example", c:[255, 0, 0])
    #endif
}

///Codable representation of a tag; same attributes
class CodableTag: Codable {
    ///Memberwise initializer to comply with Codable
    init(name: String, color: [Int]) {
        self.name = name
        self.color = color
    }
    
    var name:String
    var color:[Int] // Elements expected to be of count 3
    
    ///Converts from Tag to CodableTag
    init (t:Tag) {
        name = t.getName()
        color = t.getColor().toArray()
    }
}
