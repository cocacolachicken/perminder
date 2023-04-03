//
//  ScheduleTypes.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-25.
//

import Foundation

// Represents no schedule
struct NoSchedule: Schedule {
    var days:[Day] = [Day(i:0)]
    var type:String = "none"
    var bounds:ClosedRange<Int> = 0...0
    
    subscript (index:String) -> Day {
        get {
            return (days[0])
        }
    }
    
    func modify (day:Int, index:Int, t:Timeblock) {
        // do nothing
    }
    
    func append (day: Int, t:String) {
        // do nothing
    }
    
    init (sc:CodableSchedule) {
        // do nothing
    }
    
    init () {
        // do nothing
    }
}


// One single schedule that repeats daily
struct Daily: Schedule {
    var days:[Day] = [Day(i:0)]
    var type:String = "daily"
    var bounds:ClosedRange<Int> = 0...0
    
    subscript (index:String) -> Day {
        get {
            
            return (days[0])
        }
    }
    
    mutating func modify (day:Int, index:Int, t:Timeblock) {
        days[0].times[index] = t
    }
    
    mutating func append (day: Int, t:String) {
        days[0].times.append(Timeblock(tA:t))
    }
    
    init (sc:CodableSchedule) {
        days[0] = Day(d:sc.days[0], i: 0)
    }
    
    init () {
        
    }
}

// Schedule that contrasts a day on the weekends with a different day on the weekdays
struct BusinessDay: Schedule {
    var days:[Day] = [Day(i:0), Day(i:1)]
    var type:String = "businessday"
    var bounds:ClosedRange<Int> = 0...1
    
    subscript (index:String) -> Day {
        get {
            switch index {
                case "Sunday", "Saturday": return days[0]
                
                default: return days[1]
            }
        }
    }
    
    mutating func modify (day:Int, index:Int, t:Timeblock) {
        days[day].times[index] = t
    }
    
    mutating func append (day: Int, t:String) {
        days[day].times.append(Timeblock(tA:t))
    }
    
    init (sc:CodableSchedule) {
        for x in 0...1 {
            days[x] = Day(d:sc.days[x], i:x)
        }
    }
    
    init () {
        
    }
}

// Schedule that runs a different day for every day of the week
struct MTWTF: Schedule {
    var days:[Day] = [Day(i:0), Day(i:1), Day(i:2), Day(i:3), Day(i:4), Day(i:5), Day(i:6)]
    var type:String = "weekday"
    var bounds:ClosedRange<Int> = 0...6
    
    subscript (index:String) -> Day {
        get {
            switch index {
                case "Sunday": return days[0]
                case "Monday": return days[1]
                case "Tuesday": return days[2]
                case "Wednesday": return days[3]
                case "Thursday": return days[4]
                case "Friday": return days[5]
                case "Saturday": return days[6]
                    
                default: return days[6] // Pacifies compiler
            }
        }
    }
    
    mutating func modify (day: Int, index:Int, t:Timeblock) {
        days[day].times[index] = t
    }
    
    mutating func append (day: Int, t:String) {
        days[day].times.append(Timeblock(tA:t))
    }
    
    init (sc:CodableSchedule) {
        for x in 0...6 {
            days[x] = Day(d:sc.days[x], i:x)
        }
    }
    
    init () {
        
    }
}
