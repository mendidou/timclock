        //
        //  FirebaseModal.swift
        //  point
        //
        //  Created by mendy aouizerat  on 23/06/2020.
        //  Copyright © 2020 mendy aouizerat . All rights reserved.
        //

        import Foundation
        import FirebaseAuth
        import FirebaseDatabase
        import FirebaseStorage


        class FirebaseModal {
            
           public static let dataBaseRef = Database.database().reference()
            
            
            
            //get the name of the user as string
          public static var currentAuthName:String?{
                return Auth.auth().currentUser?.displayName
            }
            
            
            // check if guard already started
            static func guardStarted( callback:  @escaping (Bool?)->()  ){
                dataBaseRef.child(Self.currentAuthName!).child("guardStarted").observeSingleEvent(of: .value) { (result ) in
                    callback(result.value as? Bool)
                }
            }
            // read date at specific date
            static func readLastDateFromFireBase( from user:String, callBack : @escaping (String?)->() ){
                dataBaseRef.child("\(user)/lastDate").observeSingleEvent(of: .value) { (result) in
                    callBack(result.value as? String )
                    
                }
                
              }

            // save start or end of guard
            static func saveDate(callBack : @escaping (Bool)->()){
                var isGuardStart:Bool = false
                //MARK: save second guard if clickerd another time , and not overide the first guard
                // check if a guard as already started
                guardStarted { result in
                    guard let result = result else{return}
                    isGuardStart = result
                    let inOrOut = isGuardStart ? "out" : "in"
                    let dateFormatter = DateFormatter()
                    guard let currentAuthName = currentAuthName else{return}
                    
                    // run if guard as started
                    if isGuardStart{
                        dataBaseRef.child(currentAuthName).child("lastDate").observeSingleEvent(of: .value) { (lastDate) in
                            guard let lastDate:String = lastDate.value as? String else{return}
                            formateDateAndSave(with: dateFormatter, and: inOrOut, toPath: currentAuthName , guardStartedAt: lastDate)
                        }
                          // pass guard status to false
                         updateGuardStatus(isStarted: false)
                       callBack(false)
                        
                        return
                    }
                    print("out")
                    let formater = DateFormatter()
                    formater.dateFormat = "dd:MM:yyyy HH:mm:ss"
                    let guardStartedAt = formater.string(from: Date())
                    // run if no guard as started
                    formateDateAndSave(with: dateFormatter, and: inOrOut, toPath: currentAuthName , guardStartedAt: guardStartedAt)
                    
                    //pass guard status to true
                    updateGuardStatus(isStarted: true)
                    callBack(true)
                    
                }
            }
            
            
            // this methode is updating firebase if that guard as started
            private static func updateGuardStatus(isStarted:Bool){
                dataBaseRef.child(Self.currentAuthName!).child("guardStarted").setValue(isStarted)
            }
            
            //this is formating the date before saving it
            static func formateDateAndSave (with dateFormatter : DateFormatter , and inOrOut: String ,toPath currentAuthName:String , guardStartedAt : String){
                let Guard = Date()
                dateFormatter.dateFormat = "LLLL"
                let nameOfMonth = dateFormatter.string(from: Guard)
                dateFormatter.dateFormat = "EEEE"
                var nameOfDay = dateFormatter.string(from: Guard)
                dateFormatter.dateFormat = "d"
                nameOfDay = nameOfDay + " - " + dateFormatter.string(from: Guard)
                dateFormatter.dateFormat = "HH:mm:ss"
                let time = dateFormatter.string(from: Guard)
                dateFormatter.dateFormat = "dd:MM:yyyy HH:mm:ss"
                let stringDate = dateFormatter.string(from: Guard)
                 dataBaseRef.child(currentAuthName).child("lastDate").setValue(stringDate)
                dataBaseRef.child(currentAuthName).child(nameOfMonth).child(nameOfDay).child(guardStartedAt).child(inOrOut).setValue(time)
            }
            
        }

