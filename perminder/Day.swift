//
//  Day.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

struct Day: Identifiable { // Represents a day composed of many timeblocks
    var times: [Timeblock] = []
    var id:UUID = UUID()
    var index:Int
    
    func getTimes () -> [Timeblock] {
        times
    }
    
    mutating func deleteTime (index:Int) {
        times.remove(at:index)
    }
    
    mutating func addTimeBlock (time:String) {
        if !times.contains(where: {t in t.timeAssigned == time}) {
            
            times.append(Timeblock(tA:time))
            times.sort(by:{
                Int($0.timeAssigned)! < Int($1.timeAssigned)!
            })
        }
    }
    
    init (d:CodableDay, i:Int) {
        for day in d.blocks {
            times.append(Timeblock(tA: day.time))
        }
        index = i
    }
    
    init (i:Int) {
        times = []
        index = i
    }
}

class CodableDay: Codable {
    init(blocks: [CodableTimeblock] = []) {
        self.blocks = blocks
    }
    
    var blocks: [CodableTimeblock] = []
    
    init (d:Day) {
        for timeblock in d.getTimes () {
            blocks.append(CodableTimeblock(tbl:timeblock))
        }
    }
}
