//
//  perminderApp.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI

@main
struct perminderApp: App {
    var codedData:CodableDataManager?
    @StateObject var dat:DataManager
    
    init () {
        codedData = readFromJSONFile(fileName:"sav.json")
        let decodedData = codedData != nil ? DataManager(codedData!) : DataManager()
        _dat = .init(wrappedValue: decodedData)
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dat)
        }
    }
}


