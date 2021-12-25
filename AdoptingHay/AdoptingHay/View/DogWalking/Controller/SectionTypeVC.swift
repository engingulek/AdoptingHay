//
//  SectionTypeVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import UIKit
import FirebaseAuth
class SectionTypeVC: UIViewController {
    
    @IBOutlet weak var adoptingHayView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dogWalkingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        adoptingHayView.layer.cornerRadius = 15
        adoptingHayView.layer.borderWidth = 3
        adoptingHayView.layer.borderColor = UIColor.systemGray5.cgColor
        
        UserDefaults.standard.set(0, forKey: "notiA")
        
        
        nameLabel.layer.cornerRadius = 15
        nameLabel.layer.borderWidth = 3
        nameLabel.layer.borderColor = UIColor.systemGray5.cgColor
        if let displayName = Auth.auth().currentUser?.displayName as? String{
            nameLabel.text = "Hoş Geldiniz \(displayName)"
            
        }
     
        
        dogWalkingView.layer.cornerRadius = 20
        dogWalkingView.layer.borderWidth = 3
        dogWalkingView.layer.borderColor = UIColor.systemGray5.cgColor
        
        adoptingHayView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toHomePageAdoptingHay))
        adoptingHayView.addGestureRecognizer(gestureRecognizer)
        
        
        
        
        dogWalkingView.isUserInteractionEnabled = true
        let gestureRecognizerDpgWlaking = UITapGestureRecognizer(target: self, action: #selector(toHomePageDogWalking))
        dogWalkingView.addGestureRecognizer(gestureRecognizerDpgWlaking)
   
    }
    
    
    
    @objc func toHomePageAdoptingHay() {
        performSegue(withIdentifier: "toAdopHayHomePage", sender: nil)
        
    }

    
    
    @objc func toHomePageDogWalking() {
        performSegue(withIdentifier: "toDogWalking", sender: nil)
        
    }
    

}
