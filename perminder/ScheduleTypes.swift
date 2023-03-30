//
//  ScheduleTypes.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-25.
//

import Foundation

// One single schedule that repeats daily
class Daily: Schedule {
    var days:[Day] = [Day()]
    var type:String = "Daily"
    
    subscript (index:String) -> Day {
        get {
            
            return (days[0])
        }
    }
    
    func modify (day:Int, index:Int, t:Timeblock) {
        days[0].times[index] = t
    }
    
    func append (day: Int, t:String) {
        days[0].times.append(Timeblock(tA:t))
    }
}

// Schedule that contrasts a schedule on the weekends with a schedule on the weekdays
class BusinessDay: Schedule {
    var days:[Day] = [Day](repeating:Day(), count:2)
    var type:String = "BusinessDay"
    
    subscript (index:String) -> Day {
        get {
            switch index {
                case "Sunday", "Saturday": return days[0]
                
                default: return days[1]
            }
        }
    }
    
    func modify (day:Int, index:Int, t:Timeblock) {
        days[day].times[index] = t
    }
    
    func append (day: Int, t:String) {
        days[day].times.append(Timeblock(tA:t))
    }
}

// Schedule that runs a different day for every day of the week
class MTWTF: Schedule {
    var days:[Day] = [Day](repeating:Day(), count:7)
    var type:String = "Weekday"
    
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
    
    func modify (day: Int, index:Int, t:Timeblock) {
        days[day].times[index] = t
    }
    
    func append (day: Int, t:String) {
        days[day].times.append(Timeblock(tA:t))
    }
}
