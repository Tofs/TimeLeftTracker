//
//  ContentView.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-04.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var modelData : ModelData
    @State private var sendNotification = true
    
    
    
    var body: some View {
        VStack {
        
            NavigationView
            {
                List {
                    ForEach(modelData.timers) {
                        timer in
                        NavigationLink(destination: TimerDetails(model: timer, endTime: timer.endDate))
                        {
                            TimeTrackerRow(timer: timer )
                        }
                    }

                    .onDelete(perform: { indexSet in
                        modelData.timers.remove(atOffsets: indexSet)
                        modelData.save()
                    })
                }
                .navigationBarItems(leading: Text("Timers"), trailing: addButton)
            }
        }
    }

    private var addButton: some View {

        AnyView(HStack {
            Button(action: onAdd) { Image(systemName: "plus") }
            NavigationLink(destination: Settings()) { Image(systemName: "gearshape.fill") }
        })
    }
    
    private func onAdd() {
        
        var biggestId = 0;
        for item in modelData.timers{
            biggestId = max(biggestId, item.id)
        }
        
        modelData.timers.append(TimeTrackerModel(id: biggestId + 1, name: "New", active: false, endDate: Date.init()))
        modelData.save();
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
