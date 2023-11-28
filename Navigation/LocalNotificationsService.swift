//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 28.11.2023.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    func registeForLatestUpdatesIfPossible() {
        let _: Void = UNUserNotificationCenter.current()
                   .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                       if granted {
                           
                           let center = UNUserNotificationCenter.current()
                           center.removeAllPendingNotificationRequests()
                           
                           let content = UNMutableNotificationContent()
                           
                           content.title = "VK"
                           content.body = "Посмотрите последние обновления"
                           content.categoryIdentifier = "alarm"
                           content.userInfo = ["CustomData": "qwerty"]
                           content.sound = .default
                           
                           var dateComponents = DateComponents()
                           dateComponents.hour = 19
                           dateComponents.minute = 00
                           
                           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                           center.add(request)
                       }
                       else {
                           print("Доступ не получен")
                       }
                   }
    }
    
    
}
