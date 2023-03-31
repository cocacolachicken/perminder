//
//  Options.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-25.
//

import Foundation

class Options {
    var sc:Schedule?
    
    init () {
        sc = nil
    }
    
    init (src:CodableOptions, tagDB:TagDatabase) {
        sc = codableScheduleToSchedule(sch:src.sc, tagDB:tagDB)
    }
}

func codableScheduleToSchedule (sch:CodableSchedule?, tagDB:TagDatabase) -> Schedule? {
    if sch != nil {
        if (sch!.type == "daily") {
            return Daily(sc:sch!, tagDB:tagDB)
        } else if (sch!.type == "businessday") {
            return BusinessDay(sc:sch!, tagDB:tagDB)
        } else if (sch!.type == "weekday") {
            return MTWTF(sc:sch!, tagDB:tagDB)
        } else {
            return nil
        }
    } else {
        return nil
    }
}

class CodableOptions:Codable {
    var sc:CodableSchedule?
}
