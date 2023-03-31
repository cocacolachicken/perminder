//
//  IOSupport.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-26.
//

import Foundation

extension Bundle {
    // FOLLOWING BOILERPLATE CODE WAS SOURCED FROM
    
    
    func decode <T:Decodable> (file:String) -> T { // Attempts to decode and map a JSON file onto <T>
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
    
    func encode <T:Encodable> (encode:T) -> String { // Encodes an object into JSON
        let encoder = JSONEncoder()
        
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
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

func writeToFile (fileName:String, content:String) { // Writes to a file in the phone simulator!!!!!
    let fileManager = FileManager.default
    
    guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("url not found")
        return
    }
    
    print(url)
    
    let newFolderUrl = url.appendingPathComponent("perminder-files")
    
    do {
        try fileManager.createDirectory(
            at: newFolderUrl,
            withIntermediateDirectories: true,
            attributes:[:]
            )
        
        let fileURL = url.appendingPathComponent("perminder-files/\(fileName)")
        
        fileManager.createFile(
            atPath:fileURL.path,
            contents: content.data(using: String.Encoding.utf8),
            attributes:[FileAttributeKey.type:"json"]
        )
    } catch {
            print(error)
    }
}
