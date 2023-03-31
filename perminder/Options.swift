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
    
    init (src:CodableOptions) {
        sc = codableScheduleToSchedule(sch:src.sc)
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

class CodableOptions:Codable {
    init(sc: CodableSchedule? = nil) {
        self.sc = sc
    }
    
    var sc:CodableSchedule?
    
    init (opt:Options) {
        self.sc = CodableSchedule.getCodableSchedule(sch: opt.sc)
    }
}
