//
//  SingUpEmailVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.10.2021.
//

import UIKit
import Firebase


class SingUpEmailVC: UIViewController {
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldSurname: UITextField!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        singUpButton.layer.cornerRadius = 15
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
                    self.performSegue(withIdentifier: "singUptoHomePage", sender: nil)
                }}}
            
        }
    
    
    
   
        
      
    
    func alertMessage(title:String,text:String){
        let alertMessage = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Okey", style: .cancel)
        alertMessage.addAction(alertButton)
        self.present(alertMessage, animated: true)
    }
    
}
