//
//  SettingsVieiw.swift
//  perminder
//
//  Created by Tyler Gu on 2023-03-27.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dat:DataManager
    
    var body: some View {
        NavigationView {
            List {
                Section ("Scheduling") {
                    NavigationLink {
                        ScheduleView(sch:$dat.opt.sc,
                                     type: dat.opt.sc.type)
                    } label: {
                        Text("Set Schedule")
                    }
                }
            }.navigationTitle("Settings").navigationBarTitleDisplayMode(.large)
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    struct SVPreviewWrapper: View {
        @StateObject var data:DataManager = DataManager(Bundle.main.decode(file:"testdata.json"))
        
        var body: some View {
            SettingsView().environmentObject(data)
        }
    }
    
    
    static var previews: some View {
        SVPreviewWrapper()
    }
}
#endif
