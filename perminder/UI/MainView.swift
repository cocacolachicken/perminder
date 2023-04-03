//
//  MainView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-08.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dat:DataManager
    @State var showHelp:Bool = false
    
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
                
                
            
            }.navigationTitle("Home")
                .toolbar {
                Button("Help") {
                    showHelp = true;
                }.alert(isPresented: $showHelp) {
                    Alert(title: Text("Instructions"), message: Text("Touch the text field labeled \"Add new reminder\", type in a title for a reminder, and press the button with a pen and a square to add a new reminder. Touch a reminder to view its details. Touch the circle next to a reminder to mark it as complete. Swipe right on a reminder to delete it."))
                }
            }
        }.navigationViewStyle(.stack)
    }
    
    func removeReminder (at offsets: IndexSet) {
        dat.reminders.remove(atOffsets: offsets)
        writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
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
