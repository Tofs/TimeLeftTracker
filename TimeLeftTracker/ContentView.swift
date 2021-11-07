//
//  ContentView.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-04.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData : ModelData
    
    
    var body: some View {
        NavigationView
        {
            List(modelData.timers){
                timer in
                NavigationLink(destination: TimerDetails(model: timer))
                {
                 TimeTrackerRow(timer: timer)
                }
            }
            .navigationTitle("Timers")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
        }
    }
    
    private var addButton: some View {
        return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
    }
    private func onAdd() {
        
        var biggestId = 0;
        for item in modelData.timers{
            biggestId = max(biggestId, item.id)
        }
        
        modelData.timers.append(TimeTrackerModel(id: biggestId + 1, name: "New timer", active: false))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
