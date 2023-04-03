//
//  TagsView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

// Shows the tag with associated reminders
struct TagsReminderView: View {
    @EnvironmentObject var dat:DataManager
    var tag:String
    var reminders:[Int]
    
    
    init(tag:String, reminders:[Int], c:RGB) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color(red:Double(c.r)/255.0, green:Double(c.g)/255.0, blue:Double(c.b)/255.0))] // Sets the color of the title to the color
        self.tag = tag
        self.reminders = reminders
    }
    
    var body: some View {
        VStack {
            List {
                Section ("Pick a colour") { // Shows a color picker
                    ColorPicker(color:dat.tags[tag]!.getColor(), funct:{ rgb in
                        dat.tags[tag] = Tag(n:tag, c:rgb.toArray())
                        writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
                    })
                }
                
                Section ("Reminders in #\(tag)") { // Finds reminders that have the given tag
                    ForEach(reminders, id: \.self) { remind in
                        ReminderRow(i: remind, r:dat.reminders[remind], t:$dat.reminders[remind].isFinished)
                    }
                }
            }
        }.navigationTitle("#\(tag)").navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct TagsReminderView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    
    static var previews: some View {
        NavigationStack {
            HStack {
                
            }
        }
    }
}
#endif
