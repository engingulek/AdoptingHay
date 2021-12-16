//
//  MyAdvertDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 5.12.2021.
//

import UIKit
import Firebase

class MyAdvertDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    private var animalKindsListViewModel : AnimalKindsListViewModel!
    var getAdvert : MyAdvert?
    @IBOutlet weak var oneImage: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet weak var advertImage: UIImageView!
    
    @IBOutlet weak var advertName: UITextField!
    
    @IBOutlet weak var advertGenus: UITextField!
    
    @IBOutlet weak var pickerKinds: UIPickerView!
    
    @IBOutlet weak var sickSwitch: UISwitch!
    
    @IBOutlet weak var advertKinds: UILabel!
    
    @IBOutlet weak var sickInfo: UITextView!
    var sickBool:String = ""
    @IBOutlet weak var advertAge: UITextField!
    @IBOutlet weak var ownerNote: UITextView!
    var imageDetailss:[Data] = [Data]()
    
    let imagepicker = UIImagePickerController()
    let imagepickerOne = UIImagePickerController()
    let imagepickerTwo = UIImagePickerController()
    let imagepickerThird = UIImagePickerController()
    
    var imageDetailsUrl : [String] = [String]()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerKinds.delegate = self
        pickerKinds.dataSource = self
        getAnimalKindsData()
        
        
        advertImage.isUserInteractionEnabled = true
        let gestureRecognizeradvertImage = UITapGestureRecognizer(target: self, action: #selector(chooseAddAdvertImage))
        advertImage.addGestureRecognizer(gestureRecognizeradvertImage)
        
        
        thirdImage.isUserInteractionEnabled = true
        let gestureRecognizerthirdImage = UITapGestureRecognizer(target: self, action: #selector(chooseaddAdvertImageThird))
        thirdImage.addGestureRecognizer(gestureRecognizerthirdImage)
        
        
        
        
        oneImage.isUserInteractionEnabled = true
        let gestureRecognizeroneImage =  UITapGestureRecognizer(target: self, action: #selector(chooseaddAdvertImageOne))
        oneImage.addGestureRecognizer(gestureRecognizeroneImage)
        
    secondImage.isUserInteractionEnabled = true
        let gestureRecognizersecondImage = UITapGestureRecognizer(target: self, action: #selector( chooseaddAdvertImageTwo))
        secondImage.addGestureRecognizer(gestureRecognizersecondImage)
        
        

        
        
        
        
        
        
        if let name = getAdvert?.animalName {
            if let genus = getAdvert?.animalGenus{
                if let age = getAdvert?.animalAge {
                    if let sickInf = getAdvert?.animalSickInfo{
                        if let ownerNot = getAdvert?.animalOwnerNot{
                            
                            if let sickBool = getAdvert?.animalSickBool {
                                if let kinds = getAdvert?.animalKinds{
                                    self.advertName.text = name
                                    self.advertGenus.text = genus
                                    self.advertAge.text = String(age)
                                    self.ownerNote.text = ownerNot
                                    self.advertKinds.text = kinds
                                    
                                    if sickBool == "Var" {
                                        self.sickInfo.text = sickInf
                                        sickSwitch.isOn = true
                                        self.sickBool = "Var"
                                    }
                                    if sickBool == "Yok"{
                                        self.sickInfo.text = ""
                                        sickSwitch.isOn = false
                                        self.sickInfo.isUserInteractionEnabled = false
                                        self.sickBool = "Yok"
                                    }
                                    
                                    
                                    
                                   
                                    
                                }
                                
                            }
                            
                            if let adverImage = getAdvert?.animalImage {
                                let imageUrl = URL(string: adverImage)!
                                if let imageData = try? Data(contentsOf: imageUrl){
                                    self.advertImage.image = UIImage(data: imageData)
                                    
                                }
                                
                            }
                            
                            if let advertImageDetails = getAdvert?.animalImageDetails{
                                for a in advertImageDetails {
                                    let imageUrl = URL(string: a)!
                                    if let animalImageData = try?  Data(contentsOf: imageUrl){
                                        self.imageDetailss.append(animalImageData)
                                    }
                                    
                                }
                            }
                            
                            self.oneImage.image = UIImage(data: imageDetailss[0])
                            self.secondImage.image = UIImage(data: imageDetailss[1])
                            self.thirdImage.image = UIImage(data: imageDetailss[2])
                            
                           
                            
                        }
                    }
                    
                }
            }
        }
        
      
        
        self.tabBarController?.tabBar.isHidden = true
       
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker == self.imagepicker {
            advertImage.image = info[.originalImage] as? UIImage
            
        }
        if picker == self.imagepickerOne {
            oneImage.image = info[.originalImage] as? UIImage
            
        }
        
        if picker == self.imagepickerTwo {
            secondImage.image = info[.originalImage] as? UIImage
            
        }
        
        
        if picker == self.imagepickerThird {
            thirdImage.image = info[.originalImage] as? UIImage
            
        }
        
        
      
    
       
     
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func getAnimalKindsData() {
        Service().dowlandAnimalKindsFromFirestore { (animalK) in
            if let animalK = animalK {
                self.animalKindsListViewModel = AnimalKindsListViewModel(animalKindsList: animalK)
                self.pickerKinds.reloadAllComponents()
              
                
            }
        }
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
    
    
    
    @IBAction func valueChanged(_ sender: Any) {
        
        if sickSwitch.isOn {
            sickInfo.isUserInteractionEnabled = true
            self.sickBool = "Var"
        }
        else {
            sickInfo.isUserInteractionEnabled = false
            self.sickBool = "Yok"
            sickInfo.text = ""
        }
    }
    
    
    

    
    
    @IBAction func updateButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let medinaFolder = storageReferance.child("media")
        
        
        if let imageOneData = oneImage.image?.jpegData(compressionQuality: 0.5)
         {
            let imageOneDataUuid = UUID().uuidString
            let imageOneReferance = medinaFolder.child("\(imageOneDataUuid).jpeg")
            imageOneReferance.putData(imageOneData, metadata: nil) { metaData, error in
                if error == nil {
                    imageOneReferance.downloadURL { url, error in
                        let imageOneUrl = url?.absoluteString
                        self.imageDetailsUrl.append(imageOneUrl!)
                        if let imageTwoData = self.secondImage.image?.jpegData(compressionQuality: 0.5)
                         {
                            let imageTwoDataUuid = UUID().uuidString
                            let imageTwoReferance = medinaFolder.child("\(imageTwoDataUuid).jpeg")
                            imageTwoReferance.putData(imageTwoData, metadata: nil) { metaData, error in
                                if error == nil {
                                    imageTwoReferance.downloadURL { url, error in
                                        let imageTwoUrl = url?.absoluteString
                                        self.imageDetailsUrl.append(imageTwoUrl!)
                                        if let imageThirdData = self.thirdImage.image?.jpegData(compressionQuality: 0.5)
                                         {
                                            let imageThirdDataUuid = UUID().uuidString
                                            let imageThirdReferance = medinaFolder.child("\(imageThirdDataUuid).jpeg")
                                            imageThirdReferance.putData(imageThirdData, metadata: nil) { metaData, error in
                                                if error == nil {
                                                    imageThirdReferance.downloadURL { url, error in
                                                        let imageThirdUrl = url?.absoluteString
                                              
                                                        self.imageDetailsUrl.append(imageThirdUrl!)
                                                        if let advertImageData = self.advertImage.image?.jpegData(compressionQuality: 0.5){
                                                                    let uuid = UUID().uuidString
                                                                    let advertImageRefetance = medinaFolder.child("\(uuid).jpeg")
                                                                    advertImageRefetance.putData(advertImageData, metadata: nil) { metaData, error in
                                                                        if error != nil {
                                                                            print("Güncelleme resim ekleme hata \(error?.localizedDescription)")
                                                                        }
                                                                        
                                                                        else {
                                                                            advertImageRefetance.downloadURL {url, error in
                                                                                if error != nil {
                                                                                    print("Günceleme resim indirme hata")
                                                                                }
                                                                                
                                                                                else {
                                                                                   let advertImageUrl = url?.absoluteString
                                                                                    let updateData : [String : Any] =
                                                                                                                                                                                [
                                                                                                                                                                                 "animalName" : self.advertName.text!,
                                                                                                                                                                                 "animalAge"  : Int(self.advertAge.text!)!,
                                                                                                                                                                                 "animalKinds" : self.advertKinds.text!,
                                                                                                                                                                                 "animalOwnerNot" : self.ownerNote.text!,
                                                                                                                                                                                 "animalSickInfo" : self.sickInfo.text!,
                                                                                                                                                                                 "animalSick": self.sickBool,
                                                                                                                                                                                 "animalImage" : advertImageUrl!,
                                                                                "animalImageDetails" : self.imageDetailsUrl,
                                                                                                                                                                                 "animalGenus" : self.advertGenus.text!
                                                                                                                                                                                ]
                                                                                                                                                                 
                                                                                                                                                                 if let advertId = self.getAdvert?.animaluuid {
                                                                                                                                      
                                                                                                                                                                     if let userId = Auth.auth().currentUser?.uid {
                                                                                                                                                                         Service().updateMyAdvert(userId: userId, advertId: advertId, updateData: updateData)
                                                                                                                                                                         
                                                                                                                                                                         
                                                                                                                                                                         self.navigationController?.popViewController(animated: true)
                                                                                                                                                                         
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
                            }
                        }
                        
                    }
                  
                    
                }
                
                else {
                    print("Resim hatası \(error?.localizedDescription)")
                }
            }
        }
        
        
   
        
        
   
        
        
  

        
      
        
        
      
        
        
       
        
    }
    
   
    

  
    
    
}

extension MyAdvertDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        if self.animalKindsListViewModel.animalKindsAtIndex(row).name == "Hepsi" {
            if let kinds = getAdvert?.animalKinds{
                self.advertKinds.text = "Diğer"
                
            }
          
        }
        
        else {
            self.advertKinds.text = self.animalKindsListViewModel.animalKindsAtIndex(row).name
        }

        
    }
}
