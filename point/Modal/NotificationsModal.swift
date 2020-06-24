    //
    //  NotificationsModal.swift
    //  point
    //
    //  Created by mendy aouizerat  on 23/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    //

    import Foundation
    import UserNotificationsUI
    class NotificationModal :  NSObject{
        
        static let share = NotificationModal()
        let content:UNMutableNotificationContent
        let center:UNUserNotificationCenter
        let trigger :UNTimeIntervalNotificationTrigger
        
       
        private override init() {
            content = UNMutableNotificationContent()
            center = UNUserNotificationCenter.current()
            trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        }
     
        
        
    }
    extension NotificationModal:UNUserNotificationCenterDelegate{

        func requAuthorization() {
            center.requestAuthorization(options: [.alert ,.sound]) { (Bool, Error) in
                    print("hello")
            }
         }
        
       
        func sendNotification() {
        content.title = "test"
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
