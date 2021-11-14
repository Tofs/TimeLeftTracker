//
//  TimeTrackerHandler.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-04.
//

import Foundation
import Combine

final class ModelData: ObservableObject{
    
    @Published var timers: [TimeTrackerModel] = get()
    
    func save(){
        saveData(data: timers);
    }
}



func saveData(data: [TimeTrackerModel])
{
    do {
        let encoder = JSONEncoder()
        let json = try encoder.encode(data)
        
        let defaults = UserDefaults.standard
        defaults.set(json, forKey: "TimerData")
    }
    catch
    {
        fatalError("Failed store data")
    }
    
}

func get<T: Decodable>() -> T{
    do {
        let defaults = UserDefaults.standard
        let data = defaults.data(forKey: "TimerData")
        
        if (data == nil)
        {
            return load("timers.json")
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data.unsafelyUnwrapped)
    }
    catch
    {
        return load("timers.json")
    }
}


func load<T: Decodable>(_ fileName: String) -> T
{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
    else{
        fatalError("Could not find file \(fileName)")
    }

    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError(" Could not load \(fileName)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch{
        fatalError("Failed to parse \(fileName)")
    }
}
