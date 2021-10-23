//
//  SingInEmailVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.10.2021.
//

import UIKit
import Firebase


class SingInEmailVC: UIViewController {

    @IBOutlet weak var singInButton: UIButton!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    
    @IBOutlet weak var textFiledPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        singInButton.layer.cornerRadius = 15
    }
    
    @IBAction func singInButtonAction(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: textFieldEmail.text!, password: textFiledPassword.text!) { (authResult, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Hata")
            }
            else {
                self.performSegue(withIdentifier: "singInToHomePage", sender: nil)
            }
            
            
        }
        
        
        
       
        
        
    }
    


}
