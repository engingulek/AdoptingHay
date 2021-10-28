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
        Auth.auth().createUser(withEmail: textFieldEmail.text!,
        password: textFieldPassword.text!)
        { (authData, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Hata")
            }else
            {
                self.performSegue(withIdentifier: "singUptoHomePage", sender: nil)
            }}}
    
}
