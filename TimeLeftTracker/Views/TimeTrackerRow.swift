//
//  TimeTrackerRow.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-04.
//

import SwiftUI

struct TimeTrackerRow: View {
    var timer: TimeTrackerModel
    var body: some View {
        HStack{
            Text(timer.name)
            Spacer()
            if timer.active {
                Text("active")
            }
        }
    }
}

struct TimeTrackerRow_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        TimeTrackerRow(timer: modelData.timers[0])
            .environmentObject(modelData)
    }
}
