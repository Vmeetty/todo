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
    
    func schedulingNotify(inSeconds seconds: TimeInterval, contentTitle: String, contentBody: String, notifyID: String) {
        
        let currentDate = Date()
        let dueInterval = Date(timeInterval: seconds, since: currentDate)
        
        let content = UNMutableNotificationContent()
        content.title = contentTitle
        content.body = contentBody
        content.sound = UNNotificationSound.default()
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: dueInterval)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: notifyID, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
}
