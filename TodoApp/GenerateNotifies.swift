//
//  GenerateNotifies.swift
//  TodoApp
//
//  Created by vlad on 04.05.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class GenerateNotifies {
    
    static var sharedNotify: GenerateNotifies?
    private init() {
    }
    
    let notifyTitle = "My app"
    let notifyBody = "It's time to check your tasks"
    let notifyID = "myNotify"
    
    func schedulingNotify(inSeconds seconds: TimeInterval, completion: (Bool) -> ()) {
        
        let currentDate = Date()
        let dueInterval = Date(timeInterval: seconds, since: currentDate)
        
        let content = UNMutableNotificationContent()
        content.title = notifyTitle
        content.body = notifyBody
        content.sound = UNNotificationSound.default()
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: dueInterval)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: notifyID, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
}
