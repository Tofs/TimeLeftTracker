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
    
    var timerObject: TimeTrackerModel{
        modelData.timers[timerIndex]
    }
    @State var endTime: Date
    
    var body: some View {
        VStack{
            HStack {
                Text("Timer name")
                UserTextField(modelId: model.id, text: modelData.timers[timerIndex].name)
                Spacer()
            }
            HStack{
                Text("Is active")
                ActiveButton(isSet: $modelData.timers[timerIndex].active)
                Spacer()
            }
            HStack{
                DatePicker
                    .init("End Time" , selection: $endTime)
                    .onChange(of: endTime, perform: { value in
                        modelData.timers[timerIndex].endDate = endTime
                        modelData.save()
                    })
            }
            Spacer()
        }
    }
    
   
}

struct TimerDetails_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        TimerDetails(model: modelData.timers[0], endTime: modelData.timers[0].endDate)
            .environmentObject(modelData)
    }
}
