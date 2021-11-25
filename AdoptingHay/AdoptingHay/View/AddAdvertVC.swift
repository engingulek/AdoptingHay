//
//  AddAdvertVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.10.2021.
//

import UIKit
import Firebase
class AddAdvertVC: UIViewController {

    @IBOutlet weak var addAdvertImageView: UIImageView!
    
    @IBOutlet weak var addAdvertNameTextField: UITextField!
    @IBOutlet weak var addAdvertAgeTextField: UITextField!
    
    @IBOutlet weak var addAdvertKindsTextField: UITextField!
    
    @IBOutlet weak var addAdvertSickTextField: UITextField!
    
    @IBOutlet weak var addAdvertDescTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    @IBAction func addAdvert(_ sender: Any) {
        
        let userId = Auth.auth().currentUser?.uid
        if let userId = userId {
            
            
        }
        
        
       
    }
    
    
    
    
    /*func userIdAddFirebase() {
        
        let db = Firestore.firestore()
        let advertId = UUID()
        db.collection("userList").document(userId).collection("advertList").document("\(advertId)")
        
    }*/
    
    

}
