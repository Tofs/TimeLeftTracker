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
    var endDate : Date
}




extension TimeTrackerModel
{
    init(from json: Decoder) throws {
        
        let values = try json.container(keyedBy: CodingKeys.self)
        var id = 0
        
        do {
            id = try values.decode(Int.self, forKey: .id) //json["id"] as? Int
        }
        catch{}
        
        var name = ""
        do {
            name = try values.decode(String.self, forKey: .name)//json["name"] as? String
        }
        catch{}
        
        
        var activate = false
        do{
           activate = try values.decode(Bool.self, forKey: .active) //json["active"] as? Bool
        } catch{}
        
        var endDate = Date.init()
        do{
            endDate = try values.decode(Date.self, forKey: .endDate)//json["endDate"] as? Date
        } catch{}
        
        
        
          
        self.id = id
        self.name = name
        self.active = activate
        self.endDate = endDate
    }
}
