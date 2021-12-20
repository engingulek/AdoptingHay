//
//  DogWalkingAddAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.12.2021.
//

import UIKit
import Firebase

class DogWalkingAddAdvert: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var namePicker: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var ageAndGenus: UITextField!
    
    @IBOutlet weak var sickBool: UISwitch!
    
    @IBOutlet weak var sickInfo: UITextView!
    
    @IBOutlet weak var ownerNote: UITextView!
    
    @IBOutlet weak var sickBoolText: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    let imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        addImageView.isUserInteractionEnabled = true
        let gestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(addImageAction))
        addImageView.addGestureRecognizer(gestureRecognizer)
        sickInfo.isUserInteractionEnabled = false
        sickInfo.text = ""
        
        
   

        
    }
    
    
    @IBAction func swiftSelected(_ sender: Any) {
       if sickBool.isOn {
            sickInfo.isUserInteractionEnabled = true
            sickBoolText.text = "Var"
            
        }
        
        else {
            sickInfo.isUserInteractionEnabled = false
            sickBoolText.text = "Yok"
            sickInfo.text = ""
            
        }
        
    }
    
    
    //  this function will work when image tap
    @objc func addImageAction() {
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        self.present(imagepicker, animated: true, completion: nil)
        
    }
    
// Select image from photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        addImageView.image = info[.originalImage] as? UIImage
        addImageView.layer.backgroundColor = UIColor.white.cgColor
        self.dismiss(animated: true, completion: nil)
    }
    
    // Add Advert to databese action
    @IBAction func addAdvert(_ sender: Any) {
        let defaultimage = UIImage(systemName: "plus")
        
        if nameTextField.text == "" || ageAndGenus.text == "" || ownerNote.text == "" || defaultimage == addImageView.image   {
            self.alertMessage(title: "Hata", messsage: "Boş kalan alanları doldurunuz")
            
        }
        
        else {
            let storage = Storage.storage()
            let storageReferance = storage.reference()
            let medinaFolder = storageReferance.child("media")
            if let name = self.nameTextField.text {
                if let ageGenus = ageAndGenus.text {
                    if let sickInfo = sickInfo.text {
                        if let sickBool = sickBoolText.text{
                            if let ownerNote = ownerNote.text {
                                // image date to imageUrl
                                if let imageData = self.addImageView.image?.jpegData(compressionQuality: 0.5)
                                 {
                                    let imageDataUuid = UUID().uuidString
                                    let imageReferance = medinaFolder.child("\(imageDataUuid).jpeg")
                                    imageReferance.putData(imageData, metadata: nil) { metaData, error in
                                        if error == nil {
                                            imageReferance.downloadURL { url, error in
                                                let imagedUrl = url?.absoluteString
                                                
                                                if let authId = Auth.auth().currentUser?.uid as? String {
                                                    if let userName = Auth.auth().currentUser?.displayName as? String {
                                                        let date = self.datePicker.date
                                                        var time = self.timePicker.countDownDuration
                                                       time = (time/1800)*30
                                                       
                                                            
                
                                                        let advert = DogWalkAddAdvert(userId:authId,userName: userName,addImage: imagedUrl!, time: date, timeRange: String(time) , animalName: name, ageAndGenus: ageGenus, sickBool: self.sickBoolText.text!, sickInfo: sickInfo, ownerNote: ownerNote)
                                                 
                                                        DogWalkingService().addDogWalkingAdvertToFirebase(advert: advert)
                                                        self.tabBarController?.selectedIndex = 0
                                                        
                                                    }
                                                }
                                                
                                           
                                            }
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            
            
           
        }
        
    }
    
    
   

    
    // alert Message
    func alertMessage(title:String,messsage:String){
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController,animated: true, completion: nil)
    }
    


}
