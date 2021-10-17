//
//  UserTextField.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-05.
//

import SwiftUI

struct UserTextField: View {
    @EnvironmentObject var modelData: ModelData
    var modelId : Int
    
    var timerIndex: Int{
        modelData.timers.firstIndex(where: {$0.id==modelId})!
    }
    
    @State var text: String;
    var body: some View {
        TextField("Text field",
                  text: $text,
                  onEditingChanged: { _ in modelData.timers[timerIndex].name = text },
                  onCommit: { print("things")}
        )
            
    }
}

struct UserTextField_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        UserTextField(modelId: modelData.timers[0].id, text: modelData.timers[0].name)
            .environmentObject(modelData)
    }
}
