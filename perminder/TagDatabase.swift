//
//  TagDatabase.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class TagDatabase {
    var tags:[String:Tag] = [:]
    var tagsAsAnArray:[Tag] = []
    
    subscript (index:String) -> Tag {
        tags[index]!
    }
    
    func add (t:CodableTag) {
        tags[t.name] = Tag(n:t.name, s:t.subject, c:t.color)
        tagsAsAnArray.append(tags[t.name]!)
    }
}
