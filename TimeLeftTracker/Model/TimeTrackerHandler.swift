//
//  TimeTrackerHandler.swift
//  TimeLeftTracker
//
//  Created by AppTeam on 2021-09-04.
//

import Foundation
import Combine
import UserNotifications



final class ModelData: ObservableObject{
    static let UserNotificationString = "UseNotification"
    @Published var timers: [TimeTrackerModel]
    
    init() {
        timers = get()
        setupNotifications(timers)
        
    }
    static func GetUseNotification() -> Bool
    {
        return UserDefaults.standard.bool(forKey: ModelData.UserNotificationString)
    }
    
    
    func GetUseNotification() -> Bool
    {
        return UserDefaults.standard.bool(forKey: ModelData.UserNotificationString)
    }
    
    func SetUseNotification(_ value: Bool)
    {
        UserDefaults.standard.set(value, forKey: ModelData.UserNotificationString)
        setupNotifications(self.timers)
    }
    func SetUseNotification(value: Bool, comp: @escaping () -> ())
    {
        UserDefaults.standard.set(value, forKey: ModelData.UserNotificationString)
        setupNotifications(data: self.timers, completion: comp)
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

  
    
    func setupNotifications(_ data: [TimeTrackerModel]){
        setupNotifications(data: data) {
            
        }
    }
    
    
    
    func setupNotifications(data: [TimeTrackerModel], completion: @escaping () -> ()){
        
        
        
        if !GetUseNotification(){
            return;
        }
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            
            if (settings.authorizationStatus == .notDetermined)
            {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        self.setupNotifications(data: data, completion: completion)
                    } else if let error = error {
                        self.SetUseNotification(false)
                    }
                }
            }
            
            guard (settings.authorizationStatus == .authorized) ||
                  (settings.authorizationStatus == .provisional)
            else
            {
                self.SetUseNotification(false)
                completion()
                return;
            }

            
            
            
            // build notice text
            var sub = "";
            for item in data {
                if sub != ""
                {
                    sub.append("\r\n")
                }
                sub.append(contentsOf: item.name)
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Days left"
            content.subtitle = sub
            content.sound = UNNotificationSound.default
            
            
            var datComp = DateComponents()
            datComp.hour = 8
            datComp.minute = 0

            // create trigger
            let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
        
        
    }

    
    func save(){
        setupNotifications(timers)
        saveData(data: timers);
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

