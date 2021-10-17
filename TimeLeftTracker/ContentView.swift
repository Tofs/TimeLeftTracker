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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
