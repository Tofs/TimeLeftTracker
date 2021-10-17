//
//  TimeTrackerModel.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-04.
//

import Foundation



struct TimeTrackerModel :  Hashable, Codable, Identifiable{
    var id:Int
    var name:String
    var active:Bool
}
