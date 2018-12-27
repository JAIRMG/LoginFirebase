//
//  RegistroController.swift
//  LoginExample
//
//  Created by Jair Moreno Gaspar on 12/20/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class RegistroController: UIViewController {
    
    let name: UITextField = UITextField()
    let pass: UITextField = UITextField()
    let registerButton: UIButton = UIButton()
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setUpViews()
    }
    
    func setUpViews(){
        
        //Database
        ref = Database.database().reference()
        
        name.frame = CGRect(x: self.view.frame.width * 0.15, y: self.view.frame.height * 0.2, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        name.placeholder = "Correo electrónico"
        name.setBottomBorder(color: UIColor.gray)
        
        pass.frame = CGRect(x: self.view.frame.width * 0.15, y: self.view.frame.height * 0.3, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        pass.placeholder = "Contraseña"
        pass.setBottomBorder(color: UIColor.gray)
        
        registerButton.frame = CGRect(x: self.view.frame.width * 0.15, y: self.view.frame.height * 0.5, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        registerButton.layer.cornerRadius = 10
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.backgroundColor = UIColor.black
        registerButton.setTitle("Registrar", for: .normal)
        registerButton.addTarget(self, action: #selector(goToRegistro), for: .touchUpInside)
        
        
        self.view.addSubview(name)
        self.view.addSubview(pass)
        self.view.addSubview(registerButton)
    }
    
    @objc func goToRegistro(){
        guard (name.text?.count)! > 5 && ((name.text?.contains("@"))!) else {
            print("name incorrecto")
            return
        }
        
        guard (pass.text?.count)! > 5  else {
            print("pass incorrecta")
            return
        }
        
        showActivityIndicatory(uiView: self.view)
        
        Auth.auth().createUser(withEmail: name.text!, password: pass.text!) { (result, error) in
            
            if error == nil {
                print("Usuario creado")
                self.isEmailRegistered(email: self.name.text!)
            } else {
                print(error.debugDescription)
                hideActivityIndicatory()
                let alertController = UIAlertController(title: "Registro inválido", message: "Intenta de nuevo más tarde", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed default");
                }
                alertController.addAction(action1)
                self.present(alertController, animated: true, completion: nil)
                
            }
            
            
            
            
        }
        
        
    }
    
    func isEmailRegistered(email: String) {
        
        let databaseReff = Database.database().reference().child("users")
        
        databaseReff.queryOrdered(byChild: "correo").queryEqual(toValue: email).observe(.value, with: { snapshot in
            if snapshot.exists(){
                print("email exists")
                //User email exist
                hideActivityIndicatory()
                let alertController = UIAlertController(title: "Registro inválido", message: "Este correo ya se encuentra registrado", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed default");
                }
                alertController.addAction(action1)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else{
                print("email doest not exist")
                //email does not [email id available]
                let jsonUser = [
                    "correo" : self.name.text!,
                    "contrasena": self.pass.text!
                ]
                self.ref.child("users").childByAutoId().setValue(jsonUser)
                print("registro correcto")
                hideActivityIndicatory()
                self.goToInicio()
            }
            
        })
    }
    
    
    func goToInicio(){
        let inicioController = InicioController()
        self.present(inicioController, animated: true, completion: nil)
    }
    
    
}

extension UITextField
{
    func setBottomBorder(color:UIColor)
    {
        self.borderStyle = UITextField.BorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}


extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}


extension UIViewController{
    func handleError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
