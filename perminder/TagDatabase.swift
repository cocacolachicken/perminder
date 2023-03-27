//
//  TagDatabase.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

class TagDatabase {
    var tags:[String:Tag] = [:]
    
    subscript (index:String) -> Tag {
        tags[index]!
    }
    
    func add (_ t:CodableTag) {
        tags[t.name] = Tag(n:t.name)
    }
}
