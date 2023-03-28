//
//  ContentView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dat:DataManager
    
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        ContentView().environmentObject(data)
    }
}
