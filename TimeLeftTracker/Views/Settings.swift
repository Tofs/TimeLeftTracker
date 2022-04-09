//
//  settings.swift
//  TimeLeftTracker
//
//  Created by Anton Einarson on 2022-03-30.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var modelData : ModelData
    @State var notifications: Bool = false;
    
    var body: some View {
       
        VStack(alignment: .center){
            Toggle("Send notification", isOn:$notifications)
            .onChange(of: notifications)
            {
                value in
                modelData.SetUseNotification(value: notifications)
                {
                    if (notifications != modelData.GetUseNotification())
                    {
                        notifications = modelData.GetUseNotification()
                
                    }
                    
                }
                
            }
            .onAppear(){
                notifications = modelData.GetUseNotification()
            }
        }
        .padding(.horizontal)
        Spacer()
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
