//
//  TimerDetails.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-05.
//

import SwiftUI

struct TimerDetails: View {
    @EnvironmentObject var modelData: ModelData
    var model : TimeTrackerModel
    
    var timerIndex: Int{
        modelData.timers.firstIndex(where: {$0.id==model.id})!
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("Timer name")
                UserTextField(text: model.name)
        }
            Spacer()
       
        }
    }
}

struct TimerDetails_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        TimerDetails(model: modelData.timers[0])
            .environmentObject(modelData)
    }
}
