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
    
    subscript (index:Date) -> Timeblock? {
        get {
            let d = DateFormatter()
            d.dateFormat = "HHmm"
            
            return (days[0][d.string(from:index)])
        }
    }
    
    func modify (index:Int, t:Timeblock) {
        days[0][t.timeAssigned] = t
    }
}

// Schedule that contrasts a schedule on the weekends with a schedule on the weekdays
class BusinessDay: Schedule {
    var days:[Day] = [Day](repeating:Day(), count:2)
    
    subscript (index:Date) -> Timeblock? {
        get {
            let d = DateFormatter()
            d.dateFormat = "EEEE"
            
            let day = d.string(from:index)
            
            d.dateFormat = "HHmm"
            
            switch day {
                case "Sunday", "Saturday": return days[0][d.string(from:index)]
                
                default: return days[1][d.string(from:index)]
            }
        }
    }
    
    func modify (index:Int, t:Timeblock) {
        days[index][t.timeAssigned] = t
    }
}

// Schedule that runs a different day for every day of the week
class MTWTF: Schedule {
    var days:[Day] = [Day](repeating:Day(), count:7)
    
    subscript (index:Date) -> Timeblock? {
        get {
            let d = DateFormatter()
            d.dateFormat = "EEEE"
            
            let day = d.string(from:index)
            
            d.dateFormat = "HHmm"
            
            switch day {
                case "Sunday": return days[0][d.string(from:index)]
                case "Monday": return days[1][d.string(from:index)]
                case "Tuesday": return days[2][d.string(from:index)]
                case "Wednesday": return days[3][d.string(from:index)]
                case "Thursday": return days[4][d.string(from:index)]
                case "Friday": return days[5][d.string(from:index)]
                case "Saturday": return days[6][d.string(from:index)]
                    
                default: return days[6][d.string(from:index)] // Pacifies the compiler
            }
        }
    }
    
    func modify (index:Int, t:Timeblock) {
        days[index][t.timeAssigned] = t
    }
}
