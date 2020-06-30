            //
            //  LoginViewController.swift
            //  point
            //
            //  Created by mendy aouizerat  on 23/06/2020.
            //  Copyright © 2020 mendy aouizerat . All rights reserved.
            //

            import UIKit
            import FirebaseAuth


            class LoginViewController: UIViewController {

                
                @IBOutlet weak var emailField: UITextField!
                @IBOutlet weak var PasswordField: UITextField!
                // login to Firebase Auth
                @IBAction func loginBtn(_ sender: UIButton) {
                    
                guard isEmailValide && passwordIsValide ,let email = emailField.text ,let password = PasswordField.text
                    else {return}
                            
                            showProgress(title: "please Wait...")
                            sender.isEnabled = false
                    
                            Auth.auth().signIn(withEmail: email, password: password) { (result, Error) in
                                
                                guard let _ = result else{
                                    
                                    let errorMessage = Error?.localizedDescription ?? "unkown error"
                                    self.showError(title: errorMessage)
                                    sender.isEnabled = true
                                    
                                    return
                                }
                                self.showSucess()
                                Router.shared.chooseMainViewController()
                        
                            }
                }
                
                      
                override func viewDidLoad() {
                    super.viewDidLoad()
                    
                    emailField.becomeFirstResponder()

                    // Do any additional setup after loading the view.
                }
            }
