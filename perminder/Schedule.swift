//
//  Schedule.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

protocol Schedule {
    var days:[Day] {get set}

    subscript (index:Date) -> Timeblock? {get}
    
    func modify (index:Int, t:Timeblock)
}
