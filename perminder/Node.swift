//
//  Node.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-25.
//

import Foundation

class Node <T> {
    var val:T
    var next:Node<T>?
    
    init (info:T) {
        val = info
    }
    
    func add (info:T) {
        if next == nil {
            next = Node(info:info)
        } else {
            next!.add(info:info)
        }
    }
}
