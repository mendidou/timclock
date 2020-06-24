    //
    //  RegisterViewController.swift
    //  point
    //
    //  Created by mendy aouizerat  on 23/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    //

    import UIKit
    import PKHUD
    import FirebaseAuth
    import FirebaseDatabase

    class RegisterViewController: UIViewController {

        @IBOutlet weak var emailField: UITextField!
        @IBOutlet weak var NameField: UITextField!
        @IBOutlet weak var PasswordField: UITextField!
        
        @IBOutlet weak var ButtonRegister: UIButton!
        
       
        @IBAction func registerAction(_ sender: UIButton) {
            
              guard isEmailValide && passwordIsValide ,let email = emailField.text ,let password = PasswordField.text
            else {return}
            
                    var nickname = NameField.text!
                    nickname = !nickname.isEmpty ? nickname : String(email.split(separator: "@")[0])
                    showProgress(title: "please Wait...")
                    sender.isEnabled = false
                    Auth.auth().createUser(withEmail: email, password: password) { (result, Error) in
                        
                        guard let result = result else{
                            
                            let errorMessage = Error?.localizedDescription ?? "unkown error"
                            self.showError(title: errorMessage)
                            sender.isEnabled = true
                            
                            return
                        }
                        let user = result.user
                        
                        let profilChangeRequest = user.createProfileChangeRequest()
                        profilChangeRequest.displayName = nickname
                        profilChangeRequest.commitChanges { (error) in
                            if let error = error {
                                let texte = error.localizedDescription
                                self.showError(title: "Register failed" , subtitle: texte)
                                Router.shared.chooseMainViewController()
                            }else{
                                self.showSucess()
                                FirebaseModal.dataBaseRef.child(FirebaseModal.currentAuthName!).child("guardStarted").setValue(false)
                                Router.shared.chooseMainViewController()
                            }
                        }
                    }
        }
      
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }
    }
    protocol PKHUDProto {
        
    }
    extension PKHUDProto{
        func showProgress(title : String? = nil , subtitle : String? = nil)  {
            HUD.show(.labeledProgress(title: title, subtitle: subtitle))
        }
        func showError(title : String? = nil , subtitle : String? = nil)  {
            HUD.flash(.labeledError(title: title, subtitle: subtitle))
           }
        func showLabel(title : String? = nil)  {
            HUD.flash(.label(title), delay: 1)
           }
        func showSucess(title : String? = nil, subtitle : String? = nil)  {
            HUD.flash(.labeledSuccess(title: title, subtitle: subtitle), delay: 1)
           }
    }
    extension UIViewController : PKHUDProto{}
    extension FirebaseModal :PKHUDProto {}
    
    protocol UserValidation : PKHUDProto {
        var emailField : UITextField!{get}
        var PasswordField : UITextField!{get}
    }

    // protcole that help us help us make validations on password and email textfield
    extension UserValidation {
        var isEmailValide : Bool{
            guard let email = emailField.text , !email.isEmpty else{
                showLabel(title: "Email must not be empty ")
                return false
            }
            return true
        }
        var passwordIsValide : Bool{
            guard let password = PasswordField.text , !password.isEmpty else{
                showLabel(title: "Password must not be empty ")
                return false
            }
            return true
        }
    }

    extension RegisterViewController :UserValidation{}
    extension LoginViewController : UserValidation{}

