//
//  MainView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dat:DataManager
    
    var body: some View {
        NavigationView {
            List {
                Section ("Main"){
                
                    ForEach(dat.reminders) { remind in
                        NavigationLink {
                            ReminderView(remind:remind)
                        } label: { ReminderRow(remind:remind)
                            
                        }
                    }
                    
                }
            }.navigationTitle("Home").listStyle(.grouped)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        MainView().environmentObject(data)
    }
}
