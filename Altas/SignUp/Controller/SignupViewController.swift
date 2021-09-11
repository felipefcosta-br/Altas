//
//  SignupViewController.swift
//  Altas
//
//  Created by Felipe F. da Costa on 8/18/21.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    let manager = SignupManager ()
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var nameMessageLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var cityMessageLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailMessageLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordMessageLabel: UILabel!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var confirmPassawordMessageLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        nameMessageLabel.isHidden = true
        cityMessageLabel.isHidden = true
        emailMessageLabel.isHidden = true
        passwordMessageLabel.isHidden = true
        confirmPassawordMessageLabel.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    @IBAction func addNewUser(_ sender: UIButton) {
        createUser()
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
}

//MARK: - Private Extension
private extension SignupViewController {
    
    func isValidName(name: String)-> Bool{
       
        if Validator.isNotEmpty(name){
            nameMessageLabel.text = ""
            nameMessageLabel.isHidden = true
            return true
        }else{
            nameMessageLabel.text = "Please enter your name."
            nameMessageLabel.isHidden = false
            return false
        }
    }
    
    func isValidCity(city:String)-> Bool{
        
        if Validator.isNotEmpty(city) {
            cityMessageLabel.text = ""
            cityMessageLabel.isHidden = true
            return true
        }else{
            cityMessageLabel.text = "Please enter your city"
            cityMessageLabel.isHidden = false
            return false
        }
    }
    
    func isValidEmail(email: String)-> Bool{
        
        if Validator.isNotEmpty(email),
           Validator.isValidEmail(email){
            emailMessageLabel.text = ""
            emailMessageLabel.isHidden = true
            return true
        }else{
            emailMessageLabel.text = "Please enter a valid email address"
            emailMessageLabel.isHidden = false
            return false
        }
    }
    
    func isValidPassword(password: String) -> Bool{
        
        if Validator.isNotEmpty(password),
           Validator.isValidPassword(password: password){
            passwordMessageLabel.text = ""
            passwordMessageLabel.isHidden = true
            return true

        }else{
            passwordMessageLabel.text = "Minimum 8 characters containing at least one lowercase, one uppercase, one number and one special character"
            passwordMessageLabel.isHidden = false
            return false
        }
    }
    
    func isPasswordConfirmed(password: String, confirmPassword: String) -> Bool{
        
        if Validator.passwordMatch(password: password, passwordConfirmation: confirmPassword) {
            confirmPassawordMessageLabel.text = ""
            confirmPassawordMessageLabel.isHidden = true
            return true
        }else{
            confirmPassawordMessageLabel.text = "Password fields do not match"
            confirmPassawordMessageLabel.isHidden = false
            return false
        }
    }
    
    func validateTextFields () -> Bool{
        
        let validationNameResult = isValidName(name: nameTextField.text!)
        let validationCityResult = isValidCity(city: cityTextField.text!)
        let validationEmailResult = isValidEmail(email: emailTextField.text!)
        let validationPasswordResult = isValidPassword(password: passwordTextField.text!)
        let validationConfirmPasswordResult = isPasswordConfirmed(password: passwordTextField.text!,
                                                                 confirmPassword: confirmPasswordTextField.text!)
            
        guard validationNameResult,
              validationCityResult,
              validationEmailResult,
              validationPasswordResult,
              validationConfirmPasswordResult else{
                return false
            }
        return true
    }
    
    func createUser(){
        
        if validateTextFields(){
            guard let name = nameTextField.text,
                  let email = emailTextField.text,
                  let city = cityTextField.text,
                  let password = passwordTextField.text else {
                return
            }
            manager.createAppuser(name: name, email: email, city: city, password: password) { userItem, error in
                if userItem == nil {
                    if let error = error as NSError?{
                        var errorMessage: String!
                        switch AuthErrorCode(rawValue: error.code) {
                        case .operationNotAllowed:
                            errorMessage = "This operation is not allowed."
                        case .emailAlreadyInUse:
                            errorMessage = "This email is already in use."
                        case .invalidEmail:
                            errorMessage = "Please enter a valid email."
                        case .weakPassword:
                            errorMessage = "Please choose a strong password."
                        default:
                            print("Error: \(error.localizedDescription)")
                        }
                        if errorMessage != nil {
                            self.showErrorAlerts(message: errorMessage)
                        }else{
                            print("Error: \(String(describing: error))")
                        }
                        
                    }else{
                        print("Error: \(String(describing: error))")
                    }
                }
            }
        }
    }
    
    func showErrorAlerts(message: String) {
        let alertController = UIAlertController(title: "Sign up Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController,animated: true, completion: nil)
    }
    
}
