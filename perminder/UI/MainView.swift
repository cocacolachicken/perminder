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
                
                    ForEach(Array(dat.reminders.enumerated()), id: \.1.id) { (index, reminder) in
                        NavigationLink {
                            ReminderView(r:reminder, i: index).environmentObject(dat)
                        } label: {
                            ReminderRow(i: index, r:reminder, t:$dat.reminders[index].isFinished).environmentObject(dat)
                        }
                    }.onDelete (perform:removeReminder)
                }
                /*
                Section ("debug"){
                
                    Text(Bundle.main.encode(encode: dat.getCodableVersion()))
                    HStack {
                        ForEach (dat.reminders.indices, id: \.self) {ind in
                            Text(String(ind))
                        }
                    }
                }*/
                
                
            
            }.navigationTitle("Home").listStyle(.grouped).toolbar {
                EditButton()
            }
        }.navigationViewStyle(.stack)
    }
    
    func removeReminder (at offsets: IndexSet) {
        dat.reminders.remove(atOffsets: offsets)
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        MainView().environmentObject(data)
    }
}
#endif
