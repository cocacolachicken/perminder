//
//  ReminderView.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var dat:DataManager
    @State var title:String
    @State var finished:Date?
    @State var due:Date?
    @State var remind:Reminder
    @State var tags:[Tag]
    @State var tagPicked:String = ""
    var ind:Int
    
    init (r:Reminder, i:Int) {
        _remind = .init(initialValue:r)
        
        ind = i
        
        _title = .init(initialValue:r.getName())
        _finished = .init(initialValue:r.getFinished())
        _due = .init(initialValue: r.getDue())
        _tags = .init(initialValue: r.getTags())
    }
    
    var body: some View {
        List {
            VStack {
                HStack {
                    TextField(
                        "enter a title",
                        text:$title
                    ).onChange(of:title){ newVal in
                        dat.reminders[ind].changeName(str:title)
                    }.fontWeight(.semibold).font(.title)
                    
                    Spacer()
                }
                
                HStack {
                    
                    if finished != nil {
                        Text("Finished \(formatDate(date:finished!))")
                        
                    } else {
                        Text("Not finished")
                    }
                    Spacer()
                }
                
                HStack {
                    if due != nil {
                        Text("Due \(formatDate(date:remind.getCreated()))")
                        
                    } else {
                        Text("No due date")
                    }
                    Spacer()
                }
                
                HStack {
                    Text("Created \(formatDate(date:remind.getCreated()))")
                    Spacer()
                }
                
            }.listRowSeparator(.hidden)
            
            Section ("TAGS") {
                ForEach (self.tags, id:\.self) { tag in
                    NavigationLink {
                        TagsReminderView(tag:tag, reminders:dat.findAllReminders(tagIn:tag)).environmentObject(dat)
                        
                    } label: {
                        TagRow(t:tag)
                    }
                }.onDelete(perform: remove)
                
                
                
                
                HStack {
                    Button (action: {
                        let tag = dat.tags[tagPicked]
                        
                        if !tags.contains(tag ?? Tag(n:"", c:[256, 256, 256])) {
                            tags.append(tag ?? {
                                return dat.tags.createNew(n:tagPicked, c:[0, 0, 0])
                            }())
                            
                        }
                        
                        dat.reminders[ind].tags.append(dat.tags[tagPicked]!)
                        writeToFile(fileName:"sav.json", content:Bundle.main.encode(encode: dat.getCodableVersion()))
                    }) {
                        Image(systemName:"plus")
                    }
                    
                    TextField (
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
