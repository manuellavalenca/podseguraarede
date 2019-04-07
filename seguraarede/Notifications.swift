//
//  Notifications.swift
//  seguraarede
//
//  Created by Manuella Valença on 07/04/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import Foundation
import UserNotifications

public class CustomNotification {
    
    public init(isRepeated: Bool = false, identifier: String, titleNotification: String = "", contentNotification: String = "", safeHour: Int = 0, safeMinute: Int = 0) {
        let center =  UNUserNotificationCenter.current()
        
        // Content for the notification
        let content = UNMutableNotificationContent()
        content.title = titleNotification
        content.body = contentNotification
        content.sound = UNNotificationSound.default
        
        var date = DateComponents()
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        date.year = components.year
        date.month = components.month
        date.day = components.day
        date.hour = safeHour
        date.minute = safeMinute
        
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
