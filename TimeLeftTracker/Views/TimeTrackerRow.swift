//
//  TimeTrackerRow.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-04.
//

import SwiftUI

func timeLeftAsString(dateTime: Date) -> String{
    
    
    let calendar = Calendar.current
    let dateTimeNow = Date()

    // Replace the hour (time) of both dates with 00:00
    let date1 = calendar.startOfDay(for: dateTime)
    let date2 = calendar.startOfDay(for: dateTimeNow)

    let components = calendar.dateComponents([.day], from: date1, to: date2)
    let days = abs(components.day.unsafelyUnwrapped)
    return String(days)
}

struct TimeTrackerRow: View {
    var timer: TimeTrackerModel
    var body: some View {
        HStack{
            Text(timer.name)
            Spacer()
            Text(timeLeftAsString(dateTime:timer.endDate) + " Days")
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
