//
//  perminderApp.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI

@main
struct perminderApp: App {
    @StateObject var dat:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dat)
        }
    }
}


