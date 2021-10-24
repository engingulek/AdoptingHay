//
//  ViewController.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var appIcon: UIImageView!
  
    @IBOutlet weak var appTitleLabel: UILabel!
    
    @IBOutlet weak var mottoLabel: UILabel!
    
    @IBOutlet weak var goGoogleButton: UIButton!
    
    @IBOutlet weak var goEmailButton: UIButton!


    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        appTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        mottoLabel.font = UIFont.systemFont(ofSize: 27,weight: .bold)
        
        goGoogleButton.layer.cornerRadius = 15
        goEmailButton.layer.cornerRadius = 15
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    }

    @IBAction func goEmailButtonActions(_ sender: Any) {
        print("Email ile devam et")
    }
    
    @IBAction func goGoogleButtonActions(_ sender: Any) {
        
        
        let config = GIDConfiguration(clientID: "765162810048-vekuds3fj6p66tkeij2p38cip6tv40gm.apps.googleusercontent.com")
        
        
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
                 if error != nil {
                     print(error?.localizedDescription ?? "Hata")
                 }
                 else {
                    
                    let authentication = user?.authentication
                    let idToken = authentication?.idToken
                    
                    
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken!,
                                                                   accessToken: authentication!.accessToken)
                    
                    
                    Auth.auth().signIn(with: credential) { (result, error) in
                        print("Kulllanıcı id \(result?.user.uid) ")
                    }
                    
                    
                    
                    
                    
                     self.performSegue(withIdentifier: "googleSingIntoHomePage", sender: nil)
                     print("Kullanıcı email \(user?.profile?.email)")
                    
                 }
       
             

               
             }
        
       
}
        
        
    
}
    


