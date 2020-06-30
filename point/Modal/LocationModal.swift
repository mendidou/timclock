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
             let notificationModal = NotificationModal.share
             let lm = CLLocationManager()
             var currentLocation : CLLocation?
            
            //set the authorized region where to badge
                static let authorizedRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 32.3247551, longitude: 34.9238288), radius: 100, identifier: "myId")
            
            //check location if the user is in the authorized region
            var isIntheAuthorizedRegion :Bool{
                lm.requestLocation()
                guard let currenLocation = currentLocation?.coordinate else {
                 return false
                }
                return LocationManager.authorizedRegion.contains(currenLocation)
            }
        
            // chek if we have the permission for location
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
            
            //check the authorization status
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
            
           
            // send the user to parmeters if no authorisation or if the location is not enabled
            func sendTooParameters (addto View : UIViewController , texte : String) {
                  let alertController = UIAlertController(title: "Parameters", message: texte, preferredStyle: .alert)
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
            
            //if the user is out of the region
            func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
                lm.requestLocation()
                notificationModal.sendNotification(title: "Alert!", body: "you just gone from the office don't forget to unbadge 😄")
                           }
            
            //if the user is enter too the region
            func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
                lm.requestLocation()
            }
            // run when the location is updated
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                currentLocation = locations[locations.count-1]
            }
            
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                print(error)
            }
        }
        extension LocationManager : PKHUDProto{}
