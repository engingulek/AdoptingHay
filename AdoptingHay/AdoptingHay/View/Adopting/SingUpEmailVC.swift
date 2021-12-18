//
//  SingUpEmailVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.10.2021.
//

import UIKit
import Firebase
import FirebaseAuth


class SingUpEmailVC: UIViewController {
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldSurname: UITextField!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var secButtonOutlet: UIButton!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        singUpButton.layer.cornerRadius = 15
        textFieldPassword.isSecureTextEntry = true
    }
    
    
    
    
    @IBAction func secButtonAction(_ sender: Any) {
        if textFieldPassword.isSecureTextEntry == false {
            textFieldPassword.isSecureTextEntry = true
            if let image = UIImage(systemName: "eye.slash") {
                secButtonOutlet.setImage(image, for: .normal)
            }
            
        }
        else {
            textFieldPassword.isSecureTextEntry = false
            if let image = UIImage(systemName: "eye") {
                secButtonOutlet.setImage(image, for: .normal)
            }
        }
        
       
    }
    
    @IBAction func singUpButtonAction(_ sender: Any) {
        
        if textFieldName.text == "" || textFieldSurname.text == "" || textFieldEmail.text == "" || textFieldPassword.text == "" {
            self.alertMessage(title: "Hata", text: "Boş kalan yerleri lütfen doldurunuz")
        }
        
        else {
            
    
            
            
            
            
            
            
            
            
            Auth.auth().createUser(withEmail: textFieldEmail.text!,
                                   password: textFieldPassword.text!)
            { (authData, error) in
                if error != nil {
                    self.alertMessage(title: "Hata", text: error!.localizedDescription)
                }else
                {
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "\(self.textFieldName.text!) \(self.textFieldSurname.text!)"
                    changeRequest?.commitChanges(completion: { error in
                        if error == nil {
                        
                        }
                    })





                    self.performSegue(withIdentifier: "singUptoHomePage", sender: nil)
                }}
//
            
            
        }
            
        }
    
    
    
   
        
      
    
    func alertMessage(title:String,text:String){
        let alertMessage = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Okey", style: .cancel)
        alertMessage.addAction(alertButton)
        self.present(alertMessage, animated: true)
    }
    
}
