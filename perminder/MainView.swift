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
                
                AddReminderBar().environmentObject(dat)
                
                Section ("Main"){
                
                    ForEach(dat.reminders) { remind in
                        NavigationLink {
                            ReminderView(title:remind.getName(), id:remind.id).environmentObject(dat).padding()
                        } label: { ReminderRow( remindID:remind.id, toggle: dat.completeness[remind.id]!).environmentObject(dat)
                            
                        }
                    }.onDelete (perform: removeReminder)
                }
                
                
            }.toolbar {
                EditButton()
            }.navigationTitle("Home").listStyle(.grouped)
        }
    }
    
    func removeReminder (at offsets: IndexSet) {
        dat.reminders.remove(atOffsets: offsets)
    }
}

struct MainView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        MainView().environmentObject(data)
    }
}
