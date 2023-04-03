//
//  TagDatabase.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class TagDatabase { // Used to store and track all tags
    var tags:[String:Tag] = [:]
    var tagsAsAnArray:[Tag] = []
    
    subscript (index:String) -> Tag? {
        get {
            tags[index]
            
        }
        
        set {
            tags[newValue!.getName()] = newValue
            tagsAsAnArray.append(tags[newValue!.getName()]!)
        }
    }
    
    func add (t:CodableTag) {
        tags[t.name] = Tag(n:t.name, c:t.color)
        tagsAsAnArray.append(tags[t.name]!)
    }
    
    func createNew (n:String, c:[Int]) -> String {
        tags[n] = Tag (n:n, c:c)
        tagsAsAnArray.append(tags[n]!)
        return n
    }
}
