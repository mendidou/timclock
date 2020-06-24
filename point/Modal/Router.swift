//
//  Router.swift
//  point
//
//  Created by mendy aouizerat  on 23/06/2020.
//  Copyright © 2020 mendy aouizerat . All rights reserved.
//

import UIKit
import FirebaseAuth

class Router{
    weak var  window :UIWindow?
    //check if the user  is loged in
    var  isLogedIn:Bool{
        return Auth.auth().currentUser != nil
    }
    
    static let shared = Router()
    
    private init(){}
    
    func chooseMainViewController(){
        guard Thread.current.isMainThread else {
            DispatchQueue.main.async { [weak self ] in
                self?.chooseMainViewController()
            }
            return
        }
        
        let filename = isLogedIn ? "Main" : "Login"
        let sb  = UIStoryboard(name: filename, bundle: .main)
        window?.rootViewController = sb.instantiateInitialViewController()
        
    }
}
