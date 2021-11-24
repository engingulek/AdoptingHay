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
        
        if textFieldEmail.text == "" || textFiledPassword.text == "" {
            self.alertMessage(title: "Hata", text: "Boş kalan yerleri doldurunuz")
        }
        else {
            Auth.auth().signIn(withEmail: textFieldEmail.text!, password: textFiledPassword.text!) { (authResult, error) in
                if error != nil {
                    self.alertMessage(title: "Hata", text: error!.localizedDescription)

                }
                else {
                    self.performSegue(withIdentifier: "singInToHomePage", sender: nil)
                }}
            }}
    
    func alertMessage(title:String,text:String){
        let alertMessage = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Okey", style: .cancel)
        alertMessage.addAction(alertButton)
        self.present(alertMessage, animated: true)
    }
    


}
