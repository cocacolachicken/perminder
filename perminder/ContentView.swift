//
//  ContentView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dat:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    var body: some View {
        TabView {
            MainView().tabItem {
                Label("Reminders", systemImage:"house.fill")
            }
            SettingsView().tabItem {
                Label("Reminders", systemImage:"gear")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        ContentView().environmentObject(data)
    }
}
