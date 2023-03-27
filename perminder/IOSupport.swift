//
//  IOSupport.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-26.
//

import Foundation

struct Serializer {
    func serialize () {
        
    }
}

struct Deserializer {
    func deserialize () -> DataManager? {
        let decoder = JSONDecoder()
        var dat:CodableDataManager?
        
        do {
            try dat = decoder.decode(CodableDataManager.self, from:Data(from:"testdata.json" as! Decoder))
        }
        
        catch  {
            print("Ummm")
        }
        
        return dat
    }
}
