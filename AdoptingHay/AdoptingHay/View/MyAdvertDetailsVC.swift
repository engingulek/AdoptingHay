//
//  MyAdvertDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 5.12.2021.
//

import UIKit
import Firebase

class MyAdvertDetailsVC: UIViewController {
   
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
    
    @IBOutlet weak var advertAge: UITextField!
    @IBOutlet weak var ownerNote: UITextView!
    var imageDetailss:[Data] = [Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerKinds.delegate = self
        pickerKinds.dataSource = self
        getAnimalKindsData()
        
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
                                    }
                                    if sickBool == "Yok"{
                                        self.sickInfo.text = ""
                                        sickSwitch.isOn = false
                                        self.sickInfo.isUserInteractionEnabled = false
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
    
    func getAnimalKindsData() {
        Service().dowlandAnimalKindsFromFirestore { (animalK) in
            if let animalK = animalK {
                self.animalKindsListViewModel = AnimalKindsListViewModel(animalKindsList: animalK)
                self.pickerKinds.reloadAllComponents()
              
                
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
}
