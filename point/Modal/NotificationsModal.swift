    //
    //  NotificationsModal.swift
    //  point
    //
    //  Created by mendy aouizerat  on 23/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    
    
    import Foundation
    import UserNotificationsUI
    class NotificationModal :  NSObject{
        
        static let share = NotificationModal()  //singleton for notificationModal
        let content:UNMutableNotificationContent
        let center:UNUserNotificationCenter
        let trigger :UNTimeIntervalNotificationTrigger
        
       // make the builder private
        private override init() {
            content = UNMutableNotificationContent()
            center = UNUserNotificationCenter.current()
            trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        }
     
        
        
    }
    
    extension NotificationModal:UNUserNotificationCenterDelegate{
        
        // ask authorisations for Notification
        func requAuthorization() {
            center.requestAuthorization(options: [.alert ,.sound]) { (Bool, Error) in
            }
         }
        
       // send a interval notification with body and title
        func sendNotification(title:String , body:String) {
        content.title = title
        content.body = body
        content.sound = .default
        let request = UNNotificationRequest(identifier: "reminder", content: content
            , trigger: trigger)
        center.add(request) { (Error) in
            if let error = Error {
                print(error)
            }
        }
    }
    }
