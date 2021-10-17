//
//  UserTextField.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-05.
//

import SwiftUI

struct UserTextField: View {
    @EnvironmentObject var modelData : ModelData
    @State var text: String = ""
    var body: some View {
        TextField("Text field", text: $text)
    }
}

struct UserTextField_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        UserTextField(text: modelData.timers[0].name)
            .environmentObject(modelData)
    }
}
