//
//  DogWalkAccountPage.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.12.2021.
//

import UIKit
import Firebase
import Kingfisher
class DogWalkAccountPage: UIViewController {

    @IBOutlet weak var puanLabel: UILabel!
    let myImageView:UIImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
  
        accountOwner()
       design()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountOwner()
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func toFavoriList(_ sender: Any) {
        performSegue(withIdentifier: "toFav", sender: nil)
    }
    
    @IBAction func toAdvertList(_ sender: Any) {
        performSegue(withIdentifier: "toMyAdverts", sender: nil)
    }
    
    @IBAction func myOutSideListButton(_ sender: Any) {
        performSegue(withIdentifier: "isentRequest", sender: nil)
    }
    
    @IBAction func myRequestListButton(_ sender: Any) {
        performSegue(withIdentifier: "myRequestList", sender: nil)
    }
    
    @IBAction func commentButton(_ sender: Any) {
        performSegue(withIdentifier: "toComment", sender: nil)
    }
    
    
    // singOutButton
    @IBAction func singOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
     do {
       try firebaseAuth.signOut()
         performSegue(withIdentifier: "exitToSingPage", sender: nil)
     } catch let signOutError as NSError {
       print("Error signing out: %@", signOutError)
     }
    }
    
    
    @IBAction func acceptAdvertButton(_ sender: Any) {
        performSegue(withIdentifier: "k", sender: nil)
    }
    
    

    func design() {
        let myNewView=UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height/4.5))
            myNewView.backgroundColor=UIColor.blue
               
        myNewView.layer.zPosition = -1
        self.view.addSubview(myNewView)
                

        // NameLabelDesign
        let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
                myNameLabel.text = Auth.auth().currentUser?.displayName
        myNameLabel.textAlignment = .center
        myNameLabel.center.x = self.view.center.x
        myNameLabel.center.y = self.view.center.y/4.5
        myNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        myNameLabel.textColor = .white
        self.view.addSubview(myNameLabel)

        //AccountImage
                
                
             
                   
                    
              
                
                
                
    
               
                     
                       
                       
                            myImageView.contentMode = UIView.ContentMode.scaleAspectFit
                            myImageView.frame.size.width = self.view.frame.width/4
                            myImageView.frame.size.height = self.view.frame.height/8
                            myImageView.center.x = self.view.center.x
                            myImageView.center.y = self.view.center.y/2.5
                          
                            myImageView.backgroundColor = .white
                            myImageView.layer.borderColor = UIColor.blue.cgColor
                            myImageView.layer.borderWidth = 3
                            myImageView.layer.cornerRadius = 15
                            view.addSubview(myImageView)
                            
                        
                        
                    
                
    }
    
    
    
    func accountOwner() {
        let db = Firestore.firestore()
        if let getUserId = Auth.auth().currentUser?.uid {
            db.collection("userInfo").document(getUserId).getDocument { snapshot, error in
                if let userName = snapshot?.get("userName") as? String {
                    if let userImage = snapshot?.get("userImage") as? String {
                        
                       
                        self.myImageView.kf.setImage(with: URL(string: userImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
//                        myImage.kf.setImage(with: URL(string:sendImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
                    }
                    
                    
                }
            }
        }
       
    }

}
