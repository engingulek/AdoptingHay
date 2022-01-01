//
//  DogMyAdvertDetail.swift
//  AdoptingHay
//
//  Created by engin gülek on 21.12.2021.
//

import UIKit
import Firebase
class DogMyAdvertDetail: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var getAdvert: DogMyAdvert?
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    @IBOutlet weak var genusAgeLabel: UITextField!
    
    @IBOutlet weak var textViewSic: UITextView!
    
    @IBOutlet weak var sickBool: UISwitch!
    

    @IBOutlet weak var textViewOwnerNote: UITextView!
    
    @IBOutlet weak var sickBoolText: UILabel!
    
    let imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        animalImageView.isUserInteractionEnabled = true
        let gestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(addImageAction))
        animalImageView.addGestureRecognizer(gestureRecognizer)
        
        
        
        
        

        if let getAdvert = getAdvert {
            nameLabel.text = getAdvert.animalName
            genusAgeLabel.text = getAdvert.ageAndGenus
           
            textViewOwnerNote.text = getAdvert.ownerNote
            
            if getAdvert.sickBool == "Var" {
                textViewSic.isUserInteractionEnabled = true
                sickBool.isOn = true
                textViewSic.text = getAdvert.sickInfo
                sickBoolText.text = "Var"
                
            }
            
            else {
                textViewSic.isUserInteractionEnabled = false
                sickBool.isOn = false
                sickBoolText.text = "Yok"
            }
            
     let a = (getAdvert.timeRange)!/30
            timePicker.countDownDuration = TimeInterval(1800*a)
//          timePicker.countDownDuration = TimeInterval(Int(getAdvert.timeRange!)!*1800)
            
            let imageUrl = URL(string:(getAdvert.animalImage)!)!
            
            if let imageData = try?  Data(contentsOf: imageUrl) {
                self.animalImageView.image = UIImage(data: imageData)
                
                
            }
            
            if let dateAdvert = getAdvert.time {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy"
                   let year = formatter.string(from: dateAdvert)
                   formatter.dateFormat = "MM"
                   let month = formatter.string(from: dateAdvert)
                   formatter.dateFormat = "dd"
                   let day = formatter.string(from: dateAdvert)
                   
                let dayA =  Int(day)
                let yearB = Int(year)
                let monthA = Int(month)
            
               
                    let calendar = Calendar.current
                    var components = DateComponents()
                    components.day = dayA
                    components.month = monthA
                    components.year = yearB
                    datePicker.setDate(calendar.date(from: components)!, animated: true)
                
             
         
                
            }
            
         
            
        }
    }
    
    
    
    
    @objc func addImageAction() {
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        self.present(imagepicker, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       animalImageView.image = info[.originalImage] as? UIImage
       animalImageView.layer.backgroundColor = UIColor.white.cgColor
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        if sickBool.isOn {
            sickBoolText.text = "Var"
            textViewSic.isUserInteractionEnabled = true
        }
        
        else {
            sickBoolText.text = "Yok"
            textViewSic.isUserInteractionEnabled = false
            textViewSic.text = ""
        }
    }
    
    @IBAction func updateAdvert(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let medinaFolder = storageReferance.child("media")
        
        if let imageData = self.animalImageView.image?.jpegData(compressionQuality: 0.5)
         {
            let imageDataUuid = UUID().uuidString
            let imageReferance = medinaFolder.child("\(imageDataUuid).jpeg")
            imageReferance.putData(imageData, metadata: nil) { metaData, error in
                if error == nil {
                    imageReferance.downloadURL { [self] url, error in
                        let imagedUrl = url?.absoluteString
                        var time = self.timePicker.countDownDuration
                       time = (time/1800)*30
                                    if let getAdvert = self.getAdvert {
                            let updateData : [String : Any] = [
                                "ageAndGenus" : genusAgeLabel.text!,
                                "animalName" : nameLabel.text!,
                                "date" : datePicker.date,
                                "ownerNote": textViewOwnerNote.text!,
                                "sickBool"  : sickBoolText.text!,
                                "sickInfo" : textViewSic.text!,
                                "timeRange" : time,
                                "userId" : getAdvert.userId!,
                                "userName" : getAdvert.userName!,
                                "animalImage" : imagedUrl!
                            
                            ]
                            DogWalkingService().updateMyDogAdvert(userId: getAdvert.userId!, advertId: getAdvert.advertId!, updateData: updateData)
                                        self.navigationController?.popViewController(animated: true)
                            
                        }
                  
                        
                        
                    }
        
        
        
        
        
      
                                                                                                    
    }
    

}
        }
        
        
     
    }    }
