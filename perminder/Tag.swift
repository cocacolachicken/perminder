//
//  Tag.swift
//  perminder
//  A tag, meant to be given to the reminder, containing a name and a color set by the user
//
//  Created by Tyler Gu and Leqi Shen on 2023-03-21.
//

import Foundation

class Tag:Identifiable, Hashable {
    ///Method to comply with Identifiable and Hashable; assumes true if the names and colors are equal
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
    
    ///Method to comply with Hashable; combines name and color
    func hash (into hasher:inout Hasher) {
        hasher.combine(name)
        hasher.combine(color)
    }
    
    private var name:String
    @Published private var color:RGB
    var id = UUID()
    
    //initializing the name and color values
    init (n:String, c:[Int]) {
        name = n
        color = RGB(red:c[0], green:c[1], blue:c[2])
    }
    
    /**
     * gets the color in an RGB object
     * @Return the RGB object containing the set color
     */
    func getColor () -> RGB {
        color
    }
    
    /**
     * sets the color
     * @param colorSet passes in a new RGB object
     */
    func setColor(colorSet:RGB) {
        color = colorSet
    }
    
    /**
     * gets the name
     * @Return the name
     */
    func getName () -> String {
        name
    }
    
    /**
     * sets the name
     * @param nameIn the new name to be set
     */
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
