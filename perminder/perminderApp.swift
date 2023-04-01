//
//  perminderApp.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI

@main
struct perminderApp: App {
    // var codedData:CodableDataManager?
    var decodedData:DataManager
    @StateObject var dat:DataManager = DataManager()
    
    init () {
        // codedData = readFromJSONFile(fileName:"sav.json")
        // decodedData = codedData != nil ? DataManager(codedData!) : DataManager()
        decodedData = DataManager(Bundle.main.decode(file:"testdata.json"))
    }

    var body: some Scene {
        
        WindowGroup {
            ContentView().environmentObject(decodedData)
        }
    }
}


