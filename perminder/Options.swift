//
//  Options.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-25.
//

import Foundation

/// Wrapper for Schedule, but leaves room for extension
class Options {
    /// sc may be nil if the user disabled notifications or hasn't set a schedule
    var sc:Schedule?
    
    ///Initializes with a nil schedule
    init () {
        sc = nil
    }
    
    ///Initializes with a schedule based off of CodableOptions
    init (src:CodableOptions) {
        sc = codableScheduleToSchedule(sch:src.sc)
    }
}

/// Wrapper for CodableSchedule; like other Codable classes
class CodableOptions:Codable {
    ///
    init(sc: CodableSchedule? = nil) {
        self.sc = sc
    }
    
    var sc:CodableSchedule?
    
    init (opt:Options) {
        self.sc = CodableSchedule.getCodableSchedule(sch: opt.sc)
    }
}

func codableScheduleToSchedule (sch:CodableSchedule?) -> Schedule? {
    if sch != nil {
        if (sch!.type == "daily") {
            return Daily(sc:sch!)
        } else if (sch!.type == "businessday") {
            return BusinessDay(sc:sch!)
        } else if (sch!.type == "weekday") {
            return MTWTF(sc:sch!)
        } else {
            return nil
        }
    } else {
        return nil
    }
}
