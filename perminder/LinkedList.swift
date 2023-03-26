//
//  LinkedList.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-25.
//

import Foundation

class LinkedList<T> {
    var head:Node<T>?
    
    init () {
        
    }
    
    func add (info : T) {
        if head == nil {
            head = Node(info:info)
        } else {
            head!.add(info:info) // Using an exclamation mark "unwraps" an optional
        }
    }
    
    func get (index:Int) {
        
    }
    
    func del (index:Int) {
        
    }
    
}
