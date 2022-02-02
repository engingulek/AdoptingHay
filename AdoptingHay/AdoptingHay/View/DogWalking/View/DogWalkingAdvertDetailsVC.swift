//
//  DogWalkingAdvertDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import UIKit
import Firebase
class DogWalkingAdvertDetailsVC: UIViewController,UITextFieldDelegate {
    var getAdvertWalking: DogwalkingAdvert!
    
    @IBOutlet weak var advertImageView: UIImageView!
    
    @IBOutlet weak var advertRange: UILabel!
    
    @IBOutlet weak var advertAnimalName: UILabel!
    
    @IBOutlet weak var advertAnimalKindsAge: UILabel!
    
    @IBOutlet weak var animalSickInfo: UITextView!
    
    @IBOutlet weak var advertContactButton: UIButton!
    
    @IBOutlet weak var advertAddFavButton: UIButton!
    
    @IBOutlet weak var animalOwnerNote: UITextView!
    private var  messageUserListViewModel : MessageUserListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalSickInfo.isUserInteractionEnabled = false
        let imageUrl = URL(string: getAdvertWalking.advertImage!)!
        
        if let imageData = try?  Data(contentsOf: imageUrl) {
            advertImageView.image = UIImage(data: imageData)
            
        }
        
        advertContactButton.layer.cornerRadius = 15
        advertAddFavButton.layer.cornerRadius = 15

        advertAnimalName.text = "Adı: \(getAdvertWalking.advertAnimalName!)"
        
        advertRange.text = "\(getAdvertWalking.advertRange!) dk"
        advertAnimalKindsAge.text = "Cins-Yaş \(getAdvertWalking.advertAnimalKindsandAge!)"
        
        if getAdvertWalking.advertAnimalSick == "Yok" {
            self.animalSickInfo.isEditable = false
            self.animalSickInfo.text = ""
        }
        
        else {
            self.animalSickInfo.text = getAdvertWalking.sickInfo
        }
        animalOwnerNote.isEditable = false
        animalOwnerNote.text = getAdvertWalking.ownerNote
        
        

    
    }
    
    @IBAction func advertContactAction(_ sender: Any) {
        
        
        if let userId = getAdvertWalking.userId {
            if let userName = getAdvertWalking.userName {
                let sendToGetMessageData : [String:Any] = [
                    "messageGetUserId" : userId,
                    "messageGetUserName" : userName
                
                ]
                self.performSegue(withIdentifier:"a",sender: sendToGetMessageData)
                
            }
            
      
            
        }
        
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    // İstek Gönderme
    @IBAction func advertRequest(_ sender: Any) {
        DogWalkingService().sendRequest(getAdvert: getAdvertWalking)
        
        if let authUserName = Auth.auth().currentUser?.displayName {
            
            if let authUserId = Auth.auth().currentUser?.uid {
                let notiDate : [String:Any] = [
                    "sendUserName": authUserName, // gönderen kişi
                    "notiTitle":"AdoptingHay",
                    "notiSubtitle":"Bir gezdirme isteği bulunmaktadır.",
                    "notiMessage":"\(authUserName) gezdirme isteğinde bulundu",
                    "getUserName": getAdvertWalking.userName!,  // alan kişi
                    "getUserId" : getAdvertWalking.userId!,
                    "sendUserId" : authUserId
                ]
                
                DogWalkingService().addDogWalkingAdvertNoti(notiData: notiDate,getUserId:getAdvertWalking.userId!)
                
            }
            
            
            
          
        }
        
  
         
            

       
        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "a" {
            if let data = sender as? [String:Any] {
            let toDogChatVC = segue.destination as! DogChatVC
                toDogChatVC.sendToGetMessageDataChat = data
            
        }
      
        }
    }
    
    
    // Favorilere ekleme
    @IBAction func addFavAdvert(_ sender: Any) {
        DogWalkingService().addDogWalkingAdvert(getAdvert: getAdvertWalking!)
        
        if let authUserName = Auth.auth().currentUser?.displayName {
            
            if let authUserId = Auth.auth().currentUser?.uid {
                let notiDate : [String:Any] = [
                    "sendUserName": authUserName, // gönderen kişi
                    "notiTitle":"AdoptingHay",
                    "notiSubtitle":"Bir gezdirme ilanınız favorilere eklendi",
                    "notiMessage":"\(authUserName) gezdirme ilanınızı favorilerine ekledi",
                    "getUserName": getAdvertWalking.userName!,  // alan kişi
                    "getUserId" : getAdvertWalking.userId!,
                    "sendUserId": authUserId // gönderen kişi id
                ]
                
                DogWalkingService().addDogWalkingAdvertNoti(notiData: notiDate,getUserId:getAdvertWalking.userId!)
            }
      
        }
    }
}





