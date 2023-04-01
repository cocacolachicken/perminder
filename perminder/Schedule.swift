//
//  Schedule.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-21.
//

import Foundation

///Represents a given schedule
///
protocol Schedule {
    var days:[Day] {get set} // multiple days
    var type:String {get set}

    subscript (index:String) -> Day {get} // A date returns a given day. Any pattern may correspond with equal or less amoutn of days (e.g. 7-day --> 2 different days for a business/non-business-day based schedule )
    
    func modify (day:Int, index:Int, t:Timeblock) // Used to modify the days
    
    func append (day:Int, t:String)
    
    
}

class CodableSchedule:Codable {
    init(days: [CodableDay], type: String) {
        self.days = days
        self.type = type
    }
    
    var days:[CodableDay]
    var type:String
    
    init (ds:[CodableDay], t:String) {
        self.days = ds
        self.type = t
    }
    
    static func getCodableSchedule (sch:Schedule?) -> CodableSchedule? {
        if sch == nil {
            return nil
        } else {
            var ds = [CodableDay]()
            let t = sch!.type
            for day in sch!.days {
                ds.append(CodableDay(d:day))
            }
            
            
            return CodableSchedule(ds: ds, t: t)
        }
    }
}
