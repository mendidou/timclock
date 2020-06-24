    //
    //  ViewController.swift
    //  point
    //
    //  Created by mendy aouizerat  on 23/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    //
    import UIKit
    import FirebaseAuth
    import FirebaseDatabase
    import CoreLocation




    class ViewController: UIViewController {
        
        var  dateTime : Date?
        var  intervalTimer:Timer?
        var clickToLoginLabel:UILabel?
        var progressCircle : Circle?
        var basicCircle : Circle?
        var  pulseCircle : Circle?
        

        // Firebase logout Button
        
        @IBAction func signoutButton(_ sender: UIBarButtonItem) {
            do{
                       try Auth.auth().signOut()
                   }catch let e {
                       showError(title: e.localizedDescription)
                       Router.shared.chooseMainViewController()
                   }
                   Router.shared.chooseMainViewController()
        }
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            LocationManager.shared
            NotificationModal.share.requAuthorization()
            
            
            //set the color background of the view
            view.backgroundColor = .black
            
            let center = view.center
            
            // drawing the pulsating circle
            pulseCircle = Circle( drawCircleWith: .zero , color:UIColor.clear.cgColor ,
                                  fillcolor: UIColor.loginColorForpulsatin.cgColor, at: view.center)
                .animatePulsatingCircle(position :self.view.center)
                .addCircle(to: self.view)

            // drawing the basic circle
            basicCircle = Circle(drawCircleWith: center, color: UIColor.trakStrokeColor.cgColor,
                                 fillcolor: UIColor.black.cgColor , at: view.center)
                .addCircle(to: self.view)
            
            // drawing the progress circle bar
            progressCircle = Circle(drawCircleWith: center, color: UIColor.green.cgColor,
                                    stroke: 0, fillcolor: UIColor.rgb(r: 0, g: 0, b: 0, alpha: 0.4).cgColor, at: view.center)
                .addCircle(to: self.view)
            progressCircle?.animateProgressCircle(animation: 0.7).CircleLayer.strokeColor = UIColor.green.cgColor
            
            // add the click to Login label from the code and add it to the view
            clickToLoginLabel = UILabel().labelFromCode ( text: "Login",
                                frame: CGRect(x: 100, y: 100, width: 200, height: 200), textColor: .white, positionCenter: self.view.center ,
                                textAlignement: .center, View: self.view)
        
            //check if a guard as started is so update the label interval time and actived the progess circle
            FirebaseModal.guardStarted {
                guard let guardIsRunning = $0 else {
                    self.showError(title: "please check your connection")
                    return}
                // if a guard is running
                if guardIsRunning {
                    self.showProgress(title: "please wait")
                    //read the date from firebase and format from string to date.
                    FirebaseModal.readLastDateFromFireBase(from: FirebaseModal.currentAuthName!)
                    {
                       lastGuardLogin  in
                        guard let lastGuardLogin = lastGuardLogin else
                        {
                            self.showError(title: "please check your connection")
                            return
                        }
                        
                        let dateformatter = DateFormatter()
                        dateformatter.dateFormat = "dd:MM:yyyy HH:mm:ss"
                        self.dateTime =  dateformatter.date(from: lastGuardLogin)!
                        
                        // give the the timeInterval and update the label
                        self.intervalTimer = Timer.scheduledTimer(timeInterval: .oneSeconde , target: self, selector:
                            #selector(self.getIntervalTime), userInfo: nil, repeats: true)
                        
                        // animate the progress circle and the pulse color
                        self.progressCircle?.animateProgressCircle().CircleLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
                        // this function is animating the progress circle and run every minute
                        self.progressCircle?.animateProgressWithTimer(every: .oneMinute)
                         self.pulseCircle?.CircleLayer.fillColor = UIColor.pulsatingFillColor.cgColor
                        self.showSucess()
                        
                    }
                }
            }
            
            
        }
        
    }
    extension ViewController  {
        
        // this function is starting when the circle is toucht
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            let point = touch!.location(in: self.view)
           
            // is checking if the circle is toucht
            if basicCircle!.CircleLayer.path!.contains(point){
        
           //     LocationManager.shared.lm.requestLocation()
                
                
                if !LocationManager.shared.hasLocationPermision  {
                    LocationManager.shared.sendTooPermisions(addto: self, texte: "please allow location permission in the setting before")
                return
                }
                if !LocationManager.shared.isIntheAuthorizedRegion {
                    LocationManager.shared.sendTooPermisions(addto: self , texte: "please check that your location is activated")
                           return
                           }
                FirebaseModal.saveDate { [weak self] in
                    
                   
                    // run if a guard as already started
                    if $0 {
                        self?.dateTime = Date()
                        self?.progressCircle?.animateProgressCircle().CircleLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
                        
                        self?.pulseCircle?.CircleLayer.fillColor = UIColor.pulsatingFillColor.cgColor
                    
                        // give the the timeInterval
                        self?.intervalTimer = Timer.scheduledTimer(timeInterval: .oneSeconde , target: self!, selector: #selector(self?.getIntervalTime), userInfo: nil, repeats: true)
                        
                        
                        // this function is animating the progress circle and run every minute
                        self?.progressCircle?.animateProgressWithTimer(every: .oneMinute)
                        return
                    }
                    // run if no guard as started
                    self?.progressCircle?.progressTimer?.invalidate()
                    self?.intervalTimer?.invalidate()
                    
                    // turn the label to login
                    self?.clickToLoginLabel?.text = "Login"
                    
                    // if the the user loged out finish the progress circle bar and turn  the circles colors  to green
                    if let progressCircle = self?.progressCircle , let  pulseCircle = self?.pulseCircle {
                        
                        progressCircle.animateProgressCircle(animation: 1.5).CircleLayer.strokeColor = UIColor.green.cgColor
                        pulseCircle.CircleLayer.fillColor = UIColor.loginColorForpulsatin.cgColor
                    }
                    return
                }
            }
        }
        
        //get interval time from the login in Double and return Tuple of (second,minutes,hours)
        @objc func getIntervalTime(){
            let interval =  dateTime?.timeIntervalSince(Date())
            if let interval = interval {
                let  intervalInSecond : (Double ,Double ,Double) = interval.doubleToHoursMinutesSeconds()
                clickToLoginLabel?.text = "\(Int(intervalInSecond.0 * -1)):\(Int(intervalInSecond.1 * -1)):\(Int(intervalInSecond.2 * -1))"
            }
        }
       
           }
        
       
        

    extension ViewController : CLLocationManagerDelegate{}

