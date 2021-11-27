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
    var imageDetaild:[String] = [String]()
    let source = ["iPhone", "iPad", "Mac", "Apple Watch", "Apple TV", "iPod"]
    @IBOutlet weak var sickBool: UILabel!
    let imagepicker = UIImagePickerController()
    let imagepickerOne = UIImagePickerController()
    let imagepickerTwo = UIImagePickerController()
    let imagepickerThird = UIImagePickerController()
    
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
        
        
        
        
        addAdvertImageOne.isUserInteractionEnabled = true
        let gestureRecognizerImageOne = UITapGestureRecognizer(target: self, action: #selector(chooseaddAdvertImageOne))
        addAdvertImageOne.addGestureRecognizer(gestureRecognizerImageOne)
        
        
        
        addAdvertImageTwo.isUserInteractionEnabled = true
        let gestureRecognizerImageTwo = UITapGestureRecognizer(target: self, action: #selector( chooseaddAdvertImageTwo))
        addAdvertImageTwo.addGestureRecognizer(gestureRecognizerImageTwo)
        
        
        
        
        addAdvrtImageThird.isUserInteractionEnabled = true
        let gestureRecognizerImageThird = UITapGestureRecognizer(target: self, action: #selector(chooseaddAdvertImageThird))
        addAdvrtImageThird.addGestureRecognizer(gestureRecognizerImageThird)
        
        
        
        

        
        
        
        
        
        
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.clearObjects()
    }
    
    
    @objc func chooseaddAdvertImageOne() {
        
        
       
        imagepickerOne.delegate = self
        imagepickerOne.sourceType = .photoLibrary
        self.present(imagepickerOne, animated: true, completion: nil)
        
    }
    
    
    
    @objc func chooseaddAdvertImageTwo() {
        
        
       
        imagepickerTwo.delegate = self
        imagepickerTwo.sourceType = .photoLibrary
        self.present(imagepickerTwo, animated: true, completion: nil)
        
    }
    
    
    @objc func chooseaddAdvertImageThird() {
        
        
       
        imagepickerThird.delegate = self
        imagepickerThird.sourceType = .photoLibrary
        self.present(imagepickerThird, animated: true, completion: nil)
        
    }
    
    
    
   
    
    
    @objc func chooseAddAdvertImage() {
        
        
       
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        self.present(imagepicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker == self.imagepicker {
            addImageAdvert.image = info[.originalImage] as? UIImage
            
        }
        if picker == self.imagepickerOne {
            addAdvertImageOne.image = info[.originalImage] as? UIImage
            
        }
        
        if picker == self.imagepickerTwo {
            addAdvertImageTwo.image = info[.originalImage] as? UIImage
            
        }
        
        
        if picker == self.imagepickerThird {
            addAdvrtImageThird.image = info[.originalImage] as? UIImage
            
        }
        
        
      
    
       
     
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
                                    
                                    
                                    
                  
                                   if let imageOneData = addAdvertImageOne.image?.jpegData(compressionQuality: 0.5)
                                    {
                                       let imageOneDataUuid = UUID().uuidString
                                       let imageOneReferance = medinaFolder.child("\(imageOneDataUuid).jpeg")
                                       imageOneReferance.putData(imageOneData, metadata: nil) { metaData, error in
                                           if error == nil {
                                               imageOneReferance.downloadURL { url, error in
                                                   let imageOneUrl = url?.absoluteString
                                                   self.imageDetaild.append(imageOneUrl!)
                                                   
                                               }
                                             
                                               
                                           }
                                           
                                           else {
                                               print("Resim hatası \(error?.localizedDescription)")
                                           }
                                       }
                                   }
                                
                                    
                                    
                                    
                                    if let imageTwoData = self.addAdvertImageTwo.image?.jpegData(compressionQuality: 0.5)
                                     {
                                        let imageTwoDataUuid = UUID().uuidString
                                        let imageTwoReferance = medinaFolder.child("\(imageTwoDataUuid).jpeg")
                                        imageTwoReferance.putData(imageTwoData, metadata: nil) { metaData, error in
                                            if error == nil {
                                                imageTwoReferance.downloadURL { url, error in
                                                    let imageTwoUrl = url?.absoluteString
                                                    self.imageDetaild.append(imageTwoUrl!)
                                              
                                                }
                                                
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    if let imageThirdData = self.addAdvrtImageThird.image?.jpegData(compressionQuality: 0.5)
                                     {
                                        let imageThirdDataUuid = UUID().uuidString
                                        let imageThirdReferance = medinaFolder.child("\(imageThirdDataUuid).jpeg")
                                        imageThirdReferance.putData(imageThirdData, metadata: nil) { metaData, error in
                                            if error == nil {
                                                imageThirdReferance.downloadURL { url, error in
                                                    let imageThirdUrl = url?.absoluteString
                                          
                                                    self.imageDetaild.append(imageThirdUrl!)
                                                    
                                                }
                                                
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
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
                                                        let animalAdvert = AddAdvert(userName: userName, uuid: userId, animalName: AanimalName, animalKinds: self.addKindsLabel.text!, animalAge: AanimalAge, animalSickInfo: AanimalSick, animalGenus: self.addGenus.text!, animalOwnerNot: AanimalOwnerNot, animalImageDetails: self.imageDetaild, animalImage: imageUrl!, animalSickBool: self.sickBool.text!)
                                                        Service().addAdvertToFirebase(uuid: userId, advert: animalAdvert)
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
    
    
    func getAnimalKindsData() {
        Service().dowlandAnimalKindsFromFirestore { (animalK) in
            if let animalK = animalK {
                self.animalKindsListViewModel = AnimalKindsListViewModel(animalKindsList: animalK)
                self.addAdvertKindsPicker.reloadAllComponents()
              
                
            }
        }
    }
    
    
    
    func clearObjects()
    {
        
        addAdvertImageOne.image = UIImage(systemName: "plus")
        addAdvertImageOne.backgroundColor = UIColor.systemBlue
        
        addAdvertImageTwo.image = UIImage(systemName: "plus")
        addAdvertImageTwo.backgroundColor = UIColor.systemBlue
        
        
        addAdvrtImageThird.image = UIImage(systemName: "plus")
        addAdvrtImageThird.backgroundColor = UIColor.systemBlue
        
        
        addImageAdvert.image = UIImage(systemName: "plus")
        addImageAdvert.backgroundColor = UIColor.systemBlue
        
        
        
        addKindsLabel.text = ""
        
        addAge.text = ""
    addName.text = ""
        addGenus.text = ""
        addKindsLabel.text = ""
        
        addSickInfo.text = ""
        addOwnerNote.text = ""
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
        return self.animalKindsListViewModel == nil ? 0 : 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let kindsViewModel = self.animalKindsListViewModel.animalKindsAtIndex(row)
        
       
        return kindsViewModel.name != "Hepsi" ? kindsViewModel.name :
        "Diğer"
        
    
            
        
        
       
        

     
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.animalKindsListViewModel.animalKindsAtIndex(0).name
        print("Seçildi \(self.animalKindsListViewModel.animalKindsAtIndex(row).name)")
        
        self.addKindsLabel.text = self.animalKindsListViewModel.animalKindsAtIndex(row).name
    }
    
}


