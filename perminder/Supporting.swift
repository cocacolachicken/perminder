//
//  IOSupport.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-26.
//

import Foundation

extension Bundle {
    /// BOILERPLATE CODE WAS SOURCED FROM https://www.youtube.com/watch?v=J06P6AMKo5Q
    /// More for testing purposes: Bundle files cannot be saved
    
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

/// Formates a Date into a string with the format specified
func formatDate (date:Date) -> String {
    let format = DateFormatter()
    format.dateFormat = "dd MMM YYYY HH:mm"
    return format.string(from:date)
}

/// Writes a String to a file in the phone storage using UTF-8 encoding
///
/// - Parameters
///     - fileName: the name of the file to be written to
///     - content: the String to be written
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

func readFromJSONFile<T:Decodable> (fileName:String) -> T? {
    
    let fileManager = FileManager.default
    
    guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("url not found")
        return nil
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
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        guard let data = try? Data (contentsOf:fileURL) else {
            fatalError("Could not load \(fileName)")
        }
        
        guard let decodedData = try? decoder.decode(T.self, from:data) else {
            fatalError("Could not decode \(fileName) into \(T.self)")
        }
        
        return decodedData
    } catch {
            print(error)
        return nil
    }
}
