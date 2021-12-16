//
//  AnimalAdvertDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.11.2021.
//

import UIKit
import Firebase

class AnimalAdvertDetailsVC: UIViewController {
    
    
    @IBOutlet weak var animalName: UILabel!
    
    @IBOutlet weak var animalGenus: UILabel!
    
    @IBOutlet weak var animalAge: UILabel!
    
    @IBOutlet weak var sendMessage: UIButton!
    
    @IBOutlet weak var animalSick: UILabel!
    
    
    @IBOutlet weak var animalOwnerNote: UILabel!
    
    
    @IBOutlet weak var animalDetailsImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var animalAdvertDetailMesajCollectionView: UICollectionView!
    
    @IBOutlet weak var mesajText: UITextField!
    @IBOutlet weak var animalSickInfoButtonOutlet: UIButton!
    
    
    var animalImages:[Data] = [Data]()
    var autoMesaj:[String] = [String]()
    var getAnimalAdvertUid:String?
    var sicktoAlert:String?
    
    var getAnimalAdvert : AnimalAdvert?
    
    @IBOutlet weak var addFavorite: UIButton!
    
    private var animalAdvertDetailsViewModel : AnimalAdvertDetailsViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  getAnimalAdvertDetailNot()
        animalDetailsImagesCollectionView.delegate = self
        animalDetailsImagesCollectionView.dataSource = self
        
        
        animalAdvertDetailMesajCollectionView.delegate = self
        animalAdvertDetailMesajCollectionView.dataSource = self
        
        
        animalDetailsImagesCollectionView.showsHorizontalScrollIndicator = false
        animalAdvertDetailMesajCollectionView.showsHorizontalScrollIndicator = false
        
        // animalImages = ["pamukkopek","tarcinkedi","sarikus"]
        autoMesaj = ["Merhaba","İlan Akifmi","Hastalığı önemlimi","Sahiplencem"]
        
        animalDetails()
        
        //getAnimalAdvertDetails()
        
        
        // mesajcell
        
        
        // Kendi ilanlarında mesaj kısmını gizleme
        if let authUserId = Auth.auth().currentUser?.uid {
            if authUserId == getAnimalAdvert?.userId {
                mesajText.isHidden = true
                animalAdvertDetailMesajCollectionView.isHidden = true
                sendMessage.isHidden = true
                
            }
            
        }
        
        
        let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        myNameLabel.text = "İlan Detay"
        myNameLabel.textAlignment = .center
        myNameLabel.center.x = self.view.center.x
        myNameLabel.center.y = self.view.center.y/8
        myNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        myNameLabel.textColor = .red
        self.view.addSubview(myNameLabel)
        
    }
    
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        
        let userName = Auth.auth().currentUser?.displayName!
        let userId = getAnimalAdvert?.userId
        let myUserId = Auth.auth().currentUser?.uid
        
        if let myUserId = myUserId {
            if let userName = userName {
                if  let userId = userId {
                    print("UserName \(userName)  gidecek kişi \(userId)  benim id im \(myUserId)")
                    Service().addAdvertFavoriteToFirebase(advert: getAnimalAdvert!,sendUserName:userName,getuserId:userId)
                    
                    
                    
                }
                
            }
            
        }
        
        
        
        
    }
    
    
    
    func animalDetails () {
        if let getAnimalname = getAnimalAdvert?.animalName {
            if let getAnimalGenus = getAnimalAdvert?.animalGenus {
                if let getAnimalKinds = getAnimalAdvert?.animalKinds {
                    if let getAnimalAge = getAnimalAdvert?.animalAge {
                        if let getAnimakSickBool = getAnimalAdvert?.animalSick{
                            if let getAnimalAdvertOwner = getAnimalAdvert?.animalOwnerNot {
                                
                                
                                
                                self.animalName.text = "Adı : \(getAnimalname)"
                                self.animalGenus.text = "Cinsi : \(getAnimalKinds) / \(getAnimalGenus)  "
                                self.animalAge.text = "Yaş : \(getAnimalAge)"
                                self.animalSick.text = "Hastalık : \(getAnimakSickBool)"
                                self.animalOwnerNote.text = "\(getAnimalAdvertOwner)"
                                
                                
                                if getAnimakSickBool != "Yok" {
                                    self.animalSickInfoButtonOutlet.isHidden = false
                                    if let getAnimalSickInfo = getAnimalAdvert?.animalSickInfo {
                                        self.sicktoAlert = getAnimalSickInfo
                                    }
                                    
                                    
                                    
                                }
                                
                                if let getAnimalImageDetails = getAnimalAdvert?.imageDetails {
                                    for  a in getAnimalImageDetails {
                                        print("VciamgeDetails \(a)")
                                        let imageUrl = URL(string: "\(a)")!
                                        if let animalImageData = try?  Data(contentsOf: imageUrl) {
                                            
                                            print("kalae \(animalImageData)")
                                            
                                            self.animalImages.append(animalImageData)
                                            
                                            
                                            
                                        }
                                        
                                        self.animalDetailsImagesCollectionView.reloadData()
                                        
                                    }
                                }
                                
                                if let userId = getAnimalAdvert?.userId {
                                    if let authUserId = Auth.auth().currentUser?.uid {
                                        if authUserId == userId {
                                            addFavorite.isHidden = true
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
    
    
    
    
    
    
    
    
    @IBAction func messageSend(_ sender: Any) {
        
        if mesajText.text == "" {
            print("Text Boş")
        }
        
        else {
            Service().sendMessage(sendUserId: (getAnimalAdvert?.userId)!, sendUserName: (getAnimalAdvert?.userName)!, sendMessage: mesajText.text!)
        }
        
    }
    
    
    @IBAction func animalSickInfoButton(_ sender: Any) {
        
        if let sickInfo = getAnimalAdvert?.animalSickInfo {
            self.sicktoAlert = sickInfo
            
        }
        
        
        let alertController = UIAlertController(title: "Hastalık" , message: sicktoAlert, preferredStyle: .actionSheet)
        
        let close = UIAlertAction(title: "Kapat", style: .cancel) { action in
            print("Kapatıldı")
        }
        
        alertController.addAction(close)
        
        self.present(alertController, animated: true)
        
        print("Hastalık Hakkında Bilgi")
    }
    
    
    
    
    
    
    
}


extension AnimalAdvertDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.animalDetailsImagesCollectionView {
            return   animalImages.count
            
        }
        
        print("Sayi2 \(animalImages.count)")
        
        
        
        
        
        return autoMesaj.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.animalDetailsImagesCollectionView {
            let cell = animalDetailsImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "animalDetailsImageCell", for: indexPath) as! AnimalAdvertDetailsImageCVC
            
            
            cell.animalmageDetails.image = UIImage(data: animalImages[indexPath.row])
            
            print("cell kısmı13 \(animalImages.count) ")
            
            
            
            
            cell.layer.cornerRadius = 25
            
            cell.layer.borderWidth = 2
            return cell
            
        }
        
        else {
            let cell = animalAdvertDetailMesajCollectionView.dequeueReusableCell(withReuseIdentifier: "mesajcell", for: indexPath) as! AnimalAdvertDetailsMesajCVC
            cell.mesajLabel.text = autoMesaj[indexPath.row]
            cell.layer.cornerRadius = 25
            
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.red.cgColor
            cell.backgroundColor = UIColor.red
            
           
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.animalDetailsImagesCollectionView {
            
            
        }
        
        else {
            mesajText.text = autoMesaj[indexPath.row]
            
        
            
         
            
           
            
           
            
        }
    }
    
    
    
    
    
    
}
