//
//  LoginViewController.swift
//  Altas
//
//  Created by user198265 on 8/22/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle!
    let manager = LoginManager()

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailMessageLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordMessageLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        emailTextField.setLeftIcon(UIImage(named: "email")!)
        passwordTextField.setLeftIcon(UIImage(named: "lock-outline")!)
        
        handle = Auth.auth().addStateDidChangeListener{ auth, user in
            if user != nil {
                //self.performSegue(withIdentifier: Segue.showFavoritiesSpots.rawValue, sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    @IBAction func userSignIn(_ sender: UIButton) {
        if validateTextFields(){
            signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func unwindBackFromSignUp(segue: UIStoryboardSegue){}
    
}
    
//MARK: - Private Extension
private extension LoginViewController{
    
    func isValidEmail(email: String)-> Bool{
        
        if Validator.isNotEmpty(email),
           Validator.isValidEmail(email){
            emailMessageLabel.isHidden = true
            return true
        }else{
            emailMessageLabel.text = "Please enter a valid email."
            emailMessageLabel.isHidden = false
            return false
        }
    }
    
    func isValidPassword(password: String) -> Bool{
        
        if !Validator.isNotEmpty(password){
            passwordMessageLabel.text = "Please enter your password."
            passwordMessageLabel.isHidden = false
            return false
            
        } else{
            passwordMessageLabel.isHidden = true
            return true
        }
    }
    
    func validateTextFields() ->Bool{
        guard isValidEmail(email: emailTextField.text!),
             isValidPassword(password: passwordTextField.text!) else {
            return false
        }
        return true
    }
    func signIn(email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                var errorMessage: String!
                
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    errorMessage = "This operation is not allowed."
                case .userDisabled:
                    errorMessage = "User is not active"
                case.wrongPassword:
                    errorMessage = "The email or the passaword is not valid"
                case .invalidEmail:
                    errorMessage = "The email or the passaword is not valid"
                default:
                    errorMessage = "The email or the passaword is not valid"
                    print("Error: \(error.localizedDescription)")
                }
                self.showErrorAlerts(message: errorMessage)
            }else{
                self.manager.getUserData()
            }
        }
        
    }
    
    func showErrorAlerts(message: String) {
        let alertController = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController,animated: true, completion: nil)
    }
}
