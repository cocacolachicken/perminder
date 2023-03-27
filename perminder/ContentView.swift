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
        NavigationView {
            
        }.navigationTitle("I hate you! i love you!")
    }
}

struct ContentView_Previews: PreviewProvider {
    @EnvironmentObject static var data:DataManager
    
    static var previews: some View {
        ContentView().environmentObject(data)
    }
}
