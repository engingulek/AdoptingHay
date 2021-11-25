//
//  AddAdvertVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.10.2021.
//

import UIKit
import Firebase
class AddAdvertVC: UIViewController {

    @IBOutlet weak var addAdvertImageOne: UIImageView!
    
    @IBOutlet weak var addAdvertImageTwo: UIImageView!
    
   
    @IBOutlet weak var addAdvrtImageThird: UIImageView!
    
    
    @IBOutlet weak var addImageAdvert: UIImageView!
    
    

    
    
  
    @IBOutlet weak var addAdvertName: UITextField!
    

    
    @IBOutlet weak var addAdvertKindsPicker: UIPickerView!
    
    @IBOutlet weak var sickSwitch: UISwitch!
    
    
    @IBOutlet weak var addSickInfo: UITextView!
    
    @IBOutlet weak var addOwnerNote: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

 
    @IBAction func addAdvert(_ sender: Any) {
        let userId = Auth.auth().currentUser?.uid
        if let userId = userId {
           
            
            Service().addAdvertToFirebase(uuid: userId)
            
            
        }
    }
    
    
    
    
    
    /*func userIdAddFirebase() {
        
        let db = Firestore.firestore()
        let advertId = UUID()
        db.collection("userList").document(userId).collection("advertList").document("\(advertId)")
        
    }*/
    
    

}
