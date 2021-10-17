//
//  ActiveButton.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-10-17.
//

import SwiftUI

struct ActiveButton: View {
    @Binding var isSet : Bool
    
    
    var body: some View {
        Button(action: {
            isSet.toggle()
        })
        {
            Text(isSet ? "Active" : "Not Active")
        }
    }
}

struct ActiveButton_Previews: PreviewProvider {
    static var previews: some View {
        ActiveButton(isSet: .constant(true))
    }
}
