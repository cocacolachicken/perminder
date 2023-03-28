//
//  Schedule.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

protocol Schedule {
    var days:[Day] {get set} // multiple days

    subscript (index:Date) -> Timeblock? {get} // A date returns a given day. Any pattern may correspond with equal or less amoutn of days (e.g. 7-day --> 2 different days for a business/non-business-day based schedule )
    
    func modify (index:Int, t:Timeblock) // Used to modify the days
}
