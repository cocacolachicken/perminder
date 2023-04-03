//
//  TagsView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct TagsReminderView: View {
    @EnvironmentObject var dat:DataManager
    var tag:Tag
    var reminders:[Int]
    
    init(tag:Tag, reminders:[Int]) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color(red:Double(tag.getColor().r)/255.0, green:Double(tag.getColor().g)/255.0, blue:Double(tag.getColor().b)/255.0))]
        self.tag = tag
        self.reminders = reminders
    }
    
    var body: some View {
        VStack {
            List {
                Section ("Pick a colour") {
                    ColorPicker(color:tag.getColor(), funct:{ rgb in
                        dat.tags[tag.getName()]!.setColor(colorSet: rgb)
                    })
                }
                
                Section ("Reminders in #\(tag.getName())") {
                    ForEach(reminders, id: \.self) { remind in
                        ReminderRow(i: remind, r:dat.reminders[remind], t:$dat.reminders[remind].isFinished)
                    }
                }
            }
        }.navigationTitle("#\(tag.getName())").navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct TagsReminderView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    
    static var previews: some View {
        NavigationStack {
            TagsReminderView(tag:Tag.example, reminders:[0, 1]).environmentObject(data)
            
        }
    }
}
#endif
