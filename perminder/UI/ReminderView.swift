//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

// Shows one reminder on a page
struct ReminderView: View {
    @EnvironmentObject var dat:DataManager
    @State var title:String
    @State var finished:Date?
    @State var due:Date = Date()
    @State var hasDue:Bool
    @State var remind:Reminder
    @State var tags:[String]
    @State var tagPicked:String = ""
    var ind:Int
    
    init (r:Reminder, i:Int) {
        _remind = .init(initialValue:r)
        
        ind = i
        
        _title = .init(initialValue:r.getName())
        _finished = .init(initialValue:r.getFinished())
        _due = .init(initialValue: r.getDue() ?? Date())
        _hasDue = .init(initialValue: r.getDue() != nil)
        _tags = .init(initialValue: r.getTags())
    }
    
    var body: some View {
        List {
            VStack {
                HStack {
                    TextField( // Title entry
                        "enter a title",
                        text:$title
                    ).onChange(of:title){ newVal in
                        dat.reminders[ind].setName(nameSet:title)
                    }.fontWeight(.semibold).font(.title)
                    
                    Spacer()
                }
                
                HStack { // Shows the finish date
                    if finished != nil {
                        Text("Finished \(formatDate(date:finished!))")
                    } else {
                        Text("Not finished")
                    }
                    Spacer()
                }
                
                HStack { // Shows  the creation date
                    Text("Created \(formatDate(date:remind.getCreated()))")
                    Spacer()
                }
                
                HStack { // Shows a mark due date field
                    
                    if hasDue {
                        DatePicker ( // Changes the date and time chosen for a due date
                            "Due:",
                            selection: $due
                        ).datePickerStyle(.compact).onChange(of:due, perform:{ _ in
                            dat.reminders[ind].setDue(dueSet:due)
                            writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
                        })
                        
                        Text("remove").onTapGesture (perform: { // If pressed, removes the due date and sets the reminder's to nil
                            hasDue = false
                            dat.reminders[ind].setDue(dueSet:nil)
                            writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
                        })
                        
                    } else { // If there's no due date, click to add
                        Text("No due date (click to add)").onTapGesture ( perform: {
                            hasDue = true
                            dat.reminders[ind].setDue(dueSet:due)
                            writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
                        })
                    }
                    Spacer()
                }
                
            }.listRowSeparator(.hidden)
            
            Section ("TAGS") { // Shows the tags as a list
                ForEach (self.tags, id:\.self) { tag in
                    NavigationLink { // Link to the tag
                        TagsReminderView(tag:tag, reminders:dat.findAllReminders(tagIn:tag), c:dat.tags[tag]!.getColor()).environmentObject(dat)
                    } label: {
                        TagRow(t:tag)
                    }
                }.onDelete(perform: remove)
                
                HStack { // Tag entry field with a button
                    Button (action: { // Adds a tag to the reminder's tag list
                        if (!tags.contains(tagPicked)) && tagPicked != "" {
                            let tag = dat.tags[tagPicked]
                            let tagString:String? = tag != nil ? tag!.getName() : nil
                            
                            if (tagString != nil) {
                                tags.append(tagPicked)
                                dat.reminders[ind].tags.append(tagPicked)
                            } else {
                                tags.append(dat.tags.createNew(n: tagPicked, c: [0, 0, 0]))
                                dat.reminders[ind].tags.append(tagPicked)
                            }
                        }
                        
                        writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
                    }) {
                        Image(systemName:"plus")
                    }
                    
                    TextField ( // Textfield
                        "enter a tag name (case sensitive)",
                        text:$tagPicked
                    )
                }
            }
        }.scrollContentBackground(.hidden).padding(0)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.grouped)
    }
    
    func remove (at offsets: IndexSet) {
        dat.reminders[ind].tags.remove(atOffsets: offsets)
        tags.remove(atOffsets: offsets)
        writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
    }
}

#if DEBUG
struct ReminderView_Previews: PreviewProvider {
    @StateObject static var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
    
    static var previews: some View {
        NavigationStack {
            ReminderView(r:data.reminders[0], i:0).environmentObject(data)
        }
    }
}
#endif
