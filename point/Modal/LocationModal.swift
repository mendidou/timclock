    //
    //  LocationModal.swift
    //  point
    //
    //  Created by mendy aouizerat  on 23/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    //

    import Foundation
    import CoreLocation
    import UIKit

    class LocationManager : NSObject {
         static let shared = LocationManager()
         let lm = CLLocationManager()
        var currentLocation : CLLocation?
        let notificationModal = NotificationModal.share
        
        
        
      static let authorizedRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 32.3247551, longitude: 34.9238288), radius: 100, identifier: "myId")
        
        
        var isIntheAuthorizedRegion :Bool{
            lm.requestLocation()
            
            
            guard let currenLocation = currentLocation?.coordinate else {
             return false
            }
           
            return LocationManager.authorizedRegion.contains(currenLocation)
        }
        var hasLocationPermision :Bool{
            let status = CLLocationManager.authorizationStatus()
            return status == .authorizedWhenInUse || status == .authorizedAlways
        }
        
        private override init(){
            super .init()
            lm.delegate = self
        }
    }
    extension LocationManager :CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedAlways , .authorizedWhenInUse:
                lm.startMonitoring(for:LocationManager.authorizedRegion)
                case .denied:
                 break
            case .notDetermined :
                lm.requestWhenInUseAuthorization()
            default:
                break
            }
        }
        
       
        
        func sendTooPermisions (addto View : UIViewController , texte : String) {
              let alertController = UIAlertController(title: "TITLE", message: texte, preferredStyle: .alert)
                          let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                              guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                  return
                              }
                              if UIApplication.shared.canOpenURL(settingsUrl) {
                                  UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                               }
                          }
                          let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                          alertController.addAction(cancelAction)
                          alertController.addAction(settingsAction)
            View.present(alertController, animated: true, completion: nil)
            
        }
        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            lm.requestLocation()
            print("out")
            notificationModal.sendNotification()
                       }
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            lm.requestLocation()
        }
                   
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            currentLocation = locations[locations.count-1]

        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    }
    extension LocationManager : PKHUDProto{}
