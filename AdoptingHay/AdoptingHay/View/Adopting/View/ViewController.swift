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
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "b")
        backgroundImage.contentMode = .scaleToFill
        view.insertSubview(backgroundImage, at:0 )

        
      
        
        
        
        
        
        
        
    
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
          let credential = GoogleAuthProvider
            .credential(withIDToken: idToken!,
                        accessToken: authentication!.accessToken)
                    
          Auth.auth().signIn(with: credential) { (result, error) in
              
              if error == nil {
                  let db = Firestore.firestore()
                  if let userId = Auth.auth().currentUser?.uid as? String {
                      if let userName = Auth.auth().currentUser?.displayName as? String {
                          if let userImage = Auth.auth().currentUser?.photoURL as? URL {
                          
                              let userInfo : [String:Any] = [
                                  "userName": userName,
                                  "userImage": userImage.absoluteString
                              ]
                              
                              db.collection("userInfo").document(userId).setData(userInfo)
                              self.performSegue(withIdentifier: "googleSingIntoHomePage", sender: nil)
                              
                          }
                      }
                 
                      
                  }
                  
              }
              
          }
          
                 }}
}
    
    
    
   
        
        
    
}
    


