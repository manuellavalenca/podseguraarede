//
//  Notifications.swift
//  seguraarede
//
//  Created by Manuella Valença on 07/04/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import Foundation
import UserNotifications

public class CustomNotifications {
    
    public func addNotification(isRepeated: Bool = false, identifier: String, titleNotification: String = "", contentNotification: String = "") {
        // Notifications configuration
        let center =  UNUserNotificationCenter.current()
        
        // Content for the notification
        let content = UNMutableNotificationContent()
        content.title = titleNotification
        content.body = contentNotification
        content.sound = UNNotificationSound.default
        
        var date = DateComponents()
        
        date.year = user.adequateYear
        date.month = user.adequateMonth
        date.day = user.adequateDay
        date.hour = user.adequateHour
        date.minute = user.adequateMinute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
        
        request.setValue(identifier, forKey: "identifier" )
        
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }

    
}
