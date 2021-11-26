//
//  AddAdvertVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.10.2021.
//

import UIKit
import Firebase
class AddAdvertVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    

    @IBOutlet weak var addAdvertImageOne: UIImageView!
    
    @IBOutlet weak var addAdvertImageTwo: UIImageView!
    
   
    @IBOutlet weak var addAdvrtImageThird: UIImageView!
    
    
    @IBOutlet weak var addImageAdvert: UIImageView!
    
    
    
    
    @IBOutlet weak var addKindsLabel: UILabel!
    

    @IBOutlet weak var addAge: UITextField!
    
    
  
    @IBOutlet weak var addName: UITextField!
    
    @IBOutlet weak var addGenus: UITextField!
    

    
    @IBOutlet weak var addAdvertKindsPicker: UIPickerView!
    
    @IBOutlet weak var sickSwitch: UISwitch!
    
    
    @IBOutlet weak var addSickInfo: UITextView!
    
    @IBOutlet weak var addOwnerNote: UITextView!
    let source = ["iPhone", "iPad", "Mac", "Apple Watch", "Apple TV", "iPod"]
    @IBOutlet weak var sickBool: UILabel!
    
    private var animalKindsListViewModel : AnimalKindsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        addAdvertKindsPicker.delegate = self
        addAdvertKindsPicker.dataSource = self
        
        getAnimalKindsData()
        
      
        addSickInfo.isUserInteractionEnabled = false
        addSickInfo.text = ""
        sickBool.text = "Yok"
        
        
        
        
        addImageAdvert.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseAddAdvertImage))
        addImageAdvert.addGestureRecognizer(gestureRecognizer)
   
    }
    
    
    
    @objc func chooseAddAdvertImage() {
        
        
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        self.present(imagepicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        addImageAdvert.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        
        if  sickSwitch.isOn {
            addSickInfo.isUserInteractionEnabled = true
         
            sickBool.text = "Var"
        }
        else {
            addSickInfo.isUserInteractionEnabled = false
            sickBool.text = "Yok"
            
        }
       
    }
    
    
    


 
    @IBAction func addAdvert(_ sender: Any) {
        
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let medinaFolder = storageReferance.child("media")
        
   
        
        
        
        
        
        
        
        
        let userId = Auth.auth().currentUser?.uid
        let userName = Auth.auth().currentUser?.displayName
        if let userName = userName {
            
            if let userId = userId {
                
                
                if addName.text == "" ||   addOwnerNote.text == "" || addAge.text == "" || addGenus.text == "" || addKindsLabel.text == ""{
                    alertMessage(title: "Hata", text: "Boş Yerleri Doldurnuz")
                    
                    
                }
                
                else
                {
                    
                    if let AanimalName = addName.text {
                        if let AanimalSick = addSickInfo.text {
                         
                            
                            if let AanimalOwnerNot = addOwnerNote.text {
                                
                                if let AanimalAge = addAge.text {
                                    let imageDetails = ["a","b","c"]
                                    
                                    
                               
                                    
                                    
                                    
                                    
                                    
                                    
                                    if let data = addImageAdvert.image?.jpegData(compressionQuality: 0.5) {
                                        let uuid = UUID().uuidString
                                        let imagaReferance = medinaFolder.child("\(uuid).jpeg")
                                        imagaReferance.putData(data, metadata: nil) { metaData, error in
                                            if error != nil {
                                                print("HATA \(error?.localizedDescription)")
                                            }
                                            else {
                                                print("Resim stroge eklendi")
                                                
                                                imagaReferance.downloadURL { url, error  in
                                                    if error == nil {
                                                        let imageUrl = url?.absoluteString
                                                        let animalAdvert = AddAdvert(userName: userName, uuid: userId, animalName: AanimalName, animalKinds: "kindsPicker", animalAge: AanimalAge, animalSickInfo: AanimalSick, animalGenus: self.addKindsLabel.text!, animalOwnerNot: AanimalOwnerNot, animalImageDetails: imageDetails, animalImage: imageUrl!, animalSickBool: self.sickBool.text!)
                                                        Service().addAdvertToFirebase(uuid: userId, advert: animalAdvert)
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
    
    
    func getAnimalKindsData() {
        Service().dowlandAnimalKindsFromFirestore { (animalK) in
            if let animalK = animalK {
                self.animalKindsListViewModel = AnimalKindsListViewModel(animalKindsList: animalK)
                self.addAdvertKindsPicker.reloadAllComponents()
              
                
            }
        }
    }
    
    
    
    /*
     
     func getAnimalKindsData() {
         Service().dowlandAnimalKindsFromFirestore { (animalK) in
             if let animalK = animalK {
                 self.animalKindsListViewModel = AnimalKindsListViewModel(animalKindsList: animalK)
                 
                 for a in self.animalKindsListViewModel.animalKindsList {
                     if let a = a.animalKindsName {
                         self.kinds.append(a)
                        
                     
                         
                     }
                     
                     
                 }
     
     
     
     */
    
    
    func alertMessage(title:String,text:String) {
        let alertMessage = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Okey", style: .cancel)
        alertMessage.addAction(alertButton)
        self.present(alertMessage, animated: true)
    }
    
    
    
    
    /*func userIdAddFirebase() {
        
        let db = Firestore.firestore()
        let advertId = UUID()
        db.collection("userList").document(userId).collection("advertList").document("\(advertId)")
        
    }*/
    
    

}

extension AddAdvertVC :  UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.animalKindsListViewModel == nil ? 0 : 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let kindsViewModel = self.animalKindsListViewModel.animalKindsAtIndex(row)
        
        
        return kindsViewModel.name
       
        

     
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.animalKindsListViewModel.animalKindsAtIndex(0).name
        print("Seçildi \(self.animalKindsListViewModel.animalKindsAtIndex(row).name)")
        
        self.addKindsLabel.text = self.animalKindsListViewModel.animalKindsAtIndex(row).name
    }
    
}


