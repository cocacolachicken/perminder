//
//  IOSupport.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-26.
//

import Foundation

extension Bundle {
    func decode <T:Decodable> (file:String) -> T {
        guard let url = self.url(forResource:file, withExtension: nil) else {
            fatalError("Could not find \(file)")
        }
        
        guard let data = try? Data (contentsOf:url) else {
            fatalError("Could not load \(file)")
        }
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        guard let loadedData = try? decoder.decode(T.self, from:data) else {
            fatalError("Could not decode \(file) into \(T.self)")
        }
        
        return loadedData
    }
    
    func encode <T:Encodable> (encode:T) -> String {
        let encoder = JSONEncoder()
        
        encoder.dateEncodingStrategy = .iso8601
        
        guard let encoded = try? encoder.encode(encode) else {
            fatalError("Could not encode \(T.self)")
        }
        
        return String(data:encoded, encoding: .utf8)!
    }
}


func formatDate (date:Date) -> String {
    let format = DateFormatter()
    format.dateFormat = "dd MMM YYYY HH:mm"
    return format.string(from:date)
}
