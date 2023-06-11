//
//  NotificationManager.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 11.06.2023.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
       
       func localNotify(title:String,body:String,targetDate:Date){
           let center = UNUserNotificationCenter.current()
           center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
           }
           
           let content = UNMutableNotificationContent()
           content.title = title
           content.body = body
           
           let date = targetDate.addingTimeInterval(10)
           let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
           
           let uuidString = UUID().uuidString
           let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
           center.add(request) { (error) in
           }
           print("Target Date:",targetDate)
           print("Güncel Date:", Date())
           print("Format Date:",targetDate.addingTimeInterval(-30))
       }
}
