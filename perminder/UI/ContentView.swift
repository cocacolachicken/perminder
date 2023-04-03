//
//  ContentView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI


// Wrapper for the bottom tab to alternate between views
struct ContentView: View {
    @EnvironmentObject var dat:DataManager
    
    var body: some View {
        TabView {
            MainView().tabItem {
                Label("Reminders", systemImage:"house.fill")
            }.environmentObject(dat)
            SettingsView().tabItem {
                Label("Settings", systemImage:"gear")
            }.environmentObject(dat)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        ContentView().environmentObject(data)
    }
}
#endif
