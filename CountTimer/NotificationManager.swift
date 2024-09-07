//
//  NotificationManager.swift
//  CountTimer
//
//  Created by 파루파루상 on 2024/09/16.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("通知を許可します。")
            } else {
                print("通知を許可しません。")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "countDownNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知に失敗しました: \(error)")
            }
        }
    }
}
