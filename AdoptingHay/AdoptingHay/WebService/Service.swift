//
//  Service.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.11.2021.
//

import Foundation
import Firebase

class Service {
    
    var animalKindsList = [AnimalKinds]()
 
    
    var animalAdvertList = [AnimalAdvert]()
    
    
    var myAnimalAdvertList = [MyAdvert]()
    var favoriAdvertList = [FavoritList]()

    func dowlandAnimalKindsFromFirestore(completion: @escaping ([AnimalKinds]?)->()) {
        let db = Firestore.firestore()
        db.collection("animalKinds").getDocuments { snapshot, error in
            if error != nil{
                completion(nil)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let animalKindName =  document.get("animalKindsName") as? String {
                        if let animalKindsImage = document.get("animalKindsImage") as? String {
                            let imageUrl = URL(string: "\(animalKindsImage)")!
                            if let imageData = try?  Data(contentsOf: imageUrl) {
                                let animalKinds = AnimalKinds(animalKindsName: animalKindName, animalKindsImage: imageData)
                                self.animalKindsList.append(animalKinds)
                                completion(self.animalKindsList)
                            } }  }}} }
    }
    
    
    
    
    func dowlandAnimalAdvertFromFirestore(completion: @escaping ([AnimalAdvert]?)->()) {
       
        
        let db = Firestore.firestore()
        db.collection("animalAdvert").getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Bir hata oluştu")
            }
            else {
                
                for document in (snapshot?.documents)! {
                    if let animalAdvertUid = document.documentID as? String {
                        if let animalImage =  document.get("animalImage") as? String {
                            
               
                                
               if let animalName = document.get("animalName") as? String {
                                    if let animalAge = document.get("animalAge") as? Int {
              if let animalGenus = document.get("animalGenus") as? String {
                                            if let animalSick = document.get("animalSick") as? String {
                     if let animalKinds = document.get("animalKinds") as? String {

                         if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                             
                             
                             if let animalSickInfo = document.get("animalSickInfo") as? String {
                                 
                                 if let userName = document.get("userName") as? String {
                                     if let userId = document.get("userId") as? String {
                                         
                                         if let imageDetails = document.get("animalImageDetails") as? [String] {
                                             
                                             let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                 
                                             
                                             
                                             
                                           
                                             let animalAdvert = AnimalAdvert(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: imageDetails, dateEvent: a)
                                             
                                             self.animalAdvertList.append(animalAdvert)
                                             
                                             completion(self.animalAdvertList)
                                             
                                         }
                                         
                                     }
                                 }

                             }
                             
                         }
       
                         completion (self.animalAdvertList)
                  }}}}   } }}}
                }
           
        }
    }
    
    
    
    
    func filterAnimalAdvertDetails (uuid:String, completion: @escaping(AnimalAdvertDetails?)->()) {
        let db = Firestore.firestore()
        
            db.collection("animalAdvert").document(uuid).getDocument{ snapshot, error in
            
                if error != nil {
                    print(error?.localizedDescription ?? "Bir hata oluştu")}
                else {
                    if let getAnimalName = snapshot?.get("animalName") as? String {
                        
                        if let getAnimalGenus = snapshot?.get("animalGenus") as? String {
                            
                            if let getAnimalKinds = snapshot?.get("animalKinds") as? String {
                                if let getAnimalAge = snapshot?.get("animalAge") as? Int {
                                    if let getAnimalSick = snapshot?.get("animalSick") as? String {
                                        if let getAnimalOwnerNote = snapshot?.get("animalOwnerNot") as? String {
                                            
                                            if let getAnimalImageDetails = snapshot?.get("animalImageDetails") as? [String] {
                                                
                                                print("Resim string \(getAnimalImageDetails)")
                                                
                                                
                                                if let getAnimalSickInfo = snapshot?.get("animalSickInfo") as? String {
                                                    let animalAdvertDetails = AnimalAdvertDetails(animalUid: uuid, animalName: getAnimalName, animalKinds: getAnimalKinds, animalAge: getAnimalAge, animalSick: getAnimalSick, animalGenus: getAnimalGenus, animalOwnerNot: getAnimalOwnerNote, animalImageDetails: getAnimalImageDetails, animalSickInfo: getAnimalSickInfo)
                                                    
                                                    
                                                    completion(animalAdvertDetails)
                                                    
                                                }
                                                
                                               
                                                
                                            }
                                            
                                            
                                         
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                       }
                                  }
                            }}
                        
                        
                          }
                    
                  
                    
                   }}
        
    }
    
    
    
    
    func addAdvertToFirebase(uuid:String,advert:AddAdvert){
        let db = Firestore.firestore()
        let advertId = UUID()
        let docData : [String:Any] = [
            "userId": uuid,
            "userName" : advert.userName!,
            "animalGenus" : advert.animalGenus!,
            "animalAge"   :  advert.animalAge!,
            "animalImage" : advert.animalImage!,
            "animalImageDetails" : advert.animalImageDetails!,
            "animalKinds" : advert.animalKinds!,
            "animalName"  : advert.animalName!,
            "animalOwnerNot" : advert.animalOwnerNot!,
            "animalSickInfo"   :  advert.animalSickInfo!,
            "animalSick" : advert.animalSickBool
        ]
        
        db.collection("animalAdvert").document("\(advertId)").setData(docData) {
            err in
            if  err != nil {
                print("Ekleme Hata var  \(err?.localizedDescription)")
            }
            
            else {
                print("Ekleme İşlemi başarılı advertList")
            }
            
        }
        
        
        db.collection("userList").document("\(uuid)").collection("advertList").document("\(advertId)").setData(docData) {
            err in
            if  err != nil {
                print("Ekleme Hata var  \(err?.localizedDescription)")
            }
            
            else {
                print("Ekleme İşlemi başarılı user list")
            }
        }
        
    }
    
    
    func addAdvertFavoriteToFirebase(advert:AnimalAdvert){
        let db = Firestore.firestore()
       
        let docData : [String:Any] = [
            "userId": advert.userId!,
            "userName" : advert.userName!,
            "animalGenus" : advert.animalGenus!,
            "animalAge"   :  advert.animalAge!,
            "animalImage" : advert.animalImage!,
            "animalImageDetails" : advert.imageDetails,
            "animalKinds" : advert.animalKinds!,
            "animalName"  : advert.animalName!,
            "animalOwnerNot" : advert.animalOwnerNot!,
            "animalSickInfo"   :  advert.animalSickInfo!,
            "animalSick" : advert.animalSick!
        ]
        
     
        let userId = Auth.auth().currentUser?.uid
        
        if let userId = userId {
            
            db.collection("userList").document("\(userId)").collection("favoriList").document("\(advert.animalUid!)").setData(docData) {
                err in
                if  err != nil {
                    print("Ekleme Hata var  \(err?.localizedDescription)")
                }
                
                else {
                    print("Ekleme İşlemi başarılı user list")
                }
            }
            
        }
        
     
        
    }
    
    
   
    
   
    
    
    
    
    
    
    func dowlandAnimalAdvertSickBoolFromFirestore(completion: @escaping ([AnimalAdvert]?)->()) {
        
        let db = Firestore.firestore()
        animalAdvertList = [AnimalAdvert]()
        
        db.collection("animalAdvert").whereField("animalSick", isEqualTo:"Yok").getDocuments { snapshot, error in
            if error != nil {
                print("Hata var hastalık filtre")
            }
            else {
                
                for document in (snapshot?.documents)! {
                    if let animalAdvertUid = document.documentID as? String {
                        if let animalImage =  document.get("animalImage") as? String {
                            
         
                                
               if let animalName = document.get("animalName") as? String {
                                    if let animalAge = document.get("animalAge") as? Int {
              if let animalGenus = document.get("animalGenus") as? String {
                                            if let animalSick = document.get("animalSick") as? String {
                     if let animalKinds = document.get("animalKinds") as? String {

                         if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                             
                             
                             if let animalSickInfo = document.get("animalSickInfo") as? String {
                                 
                                 if let userName = document.get("userName") as? String {
                                     if let userId = document.get("userId") as? String {
                                         
                                         if let imageDetails = document.get("animalImageDetails") as? [String] {
                                             let a = Date()
                                             let animalAdvert = AnimalAdvert(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: imageDetails,dateEvent: a)
                                             
                                             self.animalAdvertList.append(animalAdvert)
                                             
                                             completion(self.animalAdvertList)
                                             
                                         }
                                         
                                     }
                                 }

                             }
                             
                         }
       
                         completion (self.animalAdvertList)
                  }}}}   } }}}
                
                
                
                
                
               
                
            }
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    func dowlandAnimalAdvertMaxtoMinFromFirestore (completion: @escaping ([AnimalAdvert]?)->()) {
        
        let db = Firestore.firestore()
        animalAdvertList = [AnimalAdvert]()
        
        db.collection("animalAdvert").order(by: "animalAge", descending: true).getDocuments { snapshot, error in
            
            if error != nil {
                print("Max to min error ")
            }
            
            else {
                for document in (snapshot?.documents)! {
                                   if let animalAdvertUid = document.documentID as? String {
                                       if let animalImage =  document.get("animalImage") as? String {
                                           
                                   
                                               
                              if let animalName = document.get("animalName") as? String {
                                                   if let animalAge = document.get("animalAge") as? Int {
                             if let animalGenus = document.get("animalGenus") as? String {
                                                           if let animalSick = document.get("animalSick") as? String {
                                    if let animalKinds = document.get("animalKinds") as? String {
                
                                        if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                                            
                                            
                                            if let animalSickInfo = document.get("animalSickInfo") as? String {
                                                
                                                if let userName = document.get("userName") as? String {
                                                    if let userId = document.get("userId") as? String {
                                                        
                                                        if let imageDetails = document.get("animalImageDetails") as? [String] {
                                                            let date = Date()
                                                            let animalAdvert = AnimalAdvert(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: imageDetails,dateEvent: date)
                                                            
                                                            self.animalAdvertList.append(animalAdvert)
                                                            
                                                            completion(self.animalAdvertList)
                                                            
                                                        }
                                                        
                                                    }
                                                }
                
                                            }
                                            
                                        }
                      
                                        completion (self.animalAdvertList)
                                 }}}}   } }}}


                
            }
        
        }
        
        
    }
    
    
    
    func dowlandAnimalAdvertAgeShortFromFirestore (shortType:Bool,completion: @escaping ([AnimalAdvert]?)->()) {
        
        let db = Firestore.firestore()
        animalAdvertList = [AnimalAdvert]()
        
        db.collection("animalAdvert").order(by: "animalAge", descending: shortType).getDocuments { snapshot, error in
            
            if error != nil {
                print("Max to min error ")
            }
            
            else {
                for document in (snapshot?.documents)! {
                                   if let animalAdvertUid = document.documentID as? String {
                                       if let animalImage =  document.get("animalImage") as? String {
                                           
                          
                                               
                              if let animalName = document.get("animalName") as? String {
                                                   if let animalAge = document.get("animalAge") as? Int {
                             if let animalGenus = document.get("animalGenus") as? String {
                                                           if let animalSick = document.get("animalSick") as? String {
                                    if let animalKinds = document.get("animalKinds") as? String {
                
                                        if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                                            
                                            
                                            if let animalSickInfo = document.get("animalSickInfo") as? String {
                                                
                                                if let userName = document.get("userName") as? String {
                                                    if let userId = document.get("userId") as? String {
                                                        if let imageDetails = document.get("animalImageDetails") as? [String] {
                                                            let date = Date()
                                                            let animalAdvert = AnimalAdvert(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: imageDetails,dateEvent: date)
                                                            
                                                            self.animalAdvertList.append(animalAdvert)
                                                            
                                                            completion(self.animalAdvertList)
                                                            
                                                        }
                                                        
                                                    }
                                                }
                
                                            }
                                            
                                        }
                      
                                        completion (self.animalAdvertList)
                                 }}}}   } }}}


                
            }
        
        }
        
        
    }
    
    
    
    func dowlandAnimalAdvertKindsFilterFromFirestore(getAnimalKinds:String, completion: @escaping ([AnimalAdvert]?)->()) {
        let db = Firestore.firestore()
        animalAdvertList = [AnimalAdvert]()
        db.collection("animalAdvert").whereField("animalKinds", isEqualTo: getAnimalKinds).getDocuments { snapshot, error in
            if error != nil {
                print("Kinds filter hata var")
                
            }
            
            else {
                
                if snapshot?.documents.count == 0 {
                    
                 completion(nil)
                   
                    
                   
                   
                }
                
                else {
                    for document in (snapshot?.documents)! {
                                       if let animalAdvertUid = document.documentID as? String {
                                           if let animalImage =  document.get("animalImage") as? String {
                                               
                                     
                                                   
                                  if let animalName = document.get("animalName") as? String {
                                                       if let animalAge = document.get("animalAge") as? Int {
                                 if let animalGenus = document.get("animalGenus") as? String {
                                                               if let animalSick = document.get("animalSick") as? String {
                                        if let animalKinds = document.get("animalKinds") as? String {
                    
                                            if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                                                
                                                
                                                if let animalSickInfo = document.get("animalSickInfo") as? String {
                                                    
                                                    if let userName = document.get("userName") as? String {
                                                        if let userId = document.get("userId") as? String {
                                                            
                                                            if let imageDetails = document.get("animalImageDetails") as? [String] {
                                                                let date = Date()
                                                                let animalAdvert = AnimalAdvert(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: imageDetails,dateEvent: date)
                                                                
                                                                self.animalAdvertList.append(animalAdvert)
                                                                
                                                                completion(self.animalAdvertList)
                                                                
                                                            }
                                                            
                                                        }
                                                    }
                    
                                                }
                                                
                                            }
                          
                                            completion (self.animalAdvertList)
                                     }}}}   } }}}
                }
              


                
            }
        }
        
    }
    
    
    
    
    func dowlandAnimalAdvertSearchBarTextFromFirestore(getSeacrhBarText:String, completion: @escaping ([AnimalAdvert]?)->()) {
        
        let db = Firestore.firestore()
        db.collection("animalAdvert").getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Bir hata oluştu")
            }
            else {
                
                for document in (snapshot?.documents)! {
                    if let animalAdvertUid = document.documentID as? String {
                        if let animalImage =  document.get("animalImage") as? String {
                            
      
                                
               if let animalName = document.get("animalName") as? String {
                                    if let animalAge = document.get("animalAge") as? Int {
              if let animalGenus = document.get("animalGenus") as? String {
                                            if let animalSick = document.get("animalSick") as? String {
                     if let animalKinds = document.get("animalKinds") as? String {

                         if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                             
                             
                             if let animalSickInfo = document.get("animalSickInfo") as? String {
                                 
                                 if let userName = document.get("userName") as? String {
                                     if let userId = document.get("userId") as? String {
                                         
                                         
                                         if let imageDetails = document.get("animalImageDetails") as? [String] {
                                             if  animalGenus.lowercased().contains(getSeacrhBarText.lowercased()) {
                                                 let date = Date()
                                                 
                                                 let animalAdvert = AnimalAdvert(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: imageDetails,dateEvent: date)
                                                 
                                                 self.animalAdvertList.append(animalAdvert)
                                                 
                                                 completion(self.animalAdvertList)
                                                 
                                               
                                             }
                                             
                                             
                                             
                                         
                                             
                                             
                                             
                                             
                                         }
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                       
                                         
                                         
                                     
                                         
                                     }
                                 }

                             }
                             
                         }
       
                         completion (self.animalAdvertList)
                  }}}}   } }}}
                }
           
        }
        
      
        
    }
    
    
    
    func dowloadMyAnimalAdvert(uuid:String, completion: @escaping ([MyAdvert]?)->()) {
        
        let db = Firestore.firestore()
        
        db.collection("userList").document("\(uuid)").collection("advertList").getDocuments { snapshot, error in
            
            if error != nil {
                completion(nil)
            }
            
            else {
                
               
                    
                    
                    for document in (snapshot?.documents)! {
                                       if let animalAdvertUid = document.documentID as? String {
                                           if let animalImage =  document.get("animalImage") as? String {
                                               
                            
                                                   
                                  if let animalName = document.get("animalName") as? String {
                                                       if let animalAge = document.get("animalAge") as? Int {
                                 if let animalGenus = document.get("animalGenus") as? String {
                                                               if let animalSick = document.get("animalSick") as? String {
                                        if let animalKinds = document.get("animalKinds") as? String {
                    
                                            if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                                                
                                                
                                                if let animalSickInfo = document.get("animalSickInfo") as? String {
                                                    
                                                    if let userName = document.get("userName") as? String {
                                                        if let userId = document.get("userId") as? String {
                                                            
                                                            if let animalImageDetails = document.get("animalImageDetails") as? [String] {
                                                                
                                                                
                                                                let myAnimalAdvert = MyAdvert(userName: userName, userid: userId, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSickInfo: animalSickInfo, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalImageDetails: animalImageDetails, animalImage: animalImage, animalSickBool: animalSick, animaluuid: animalAdvertUid)
                                                                
                                                                self.myAnimalAdvertList.append(myAnimalAdvert)
                                                                completion(self.myAnimalAdvertList)
                                                                
                                                                
                                                                
                                                            }
                                                            
                                                         
                                                            
                                                           
                                                            
                                                        }
                                                    }
                    
                                                }
                                                
                                            }
                          
                                  
                                     }}}}   } }}
                  
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            
        }
        
    }
    
    
    
    
  
    
    
    
    func dowloadFavoriteListAdvert(uuid:String, completion: @escaping ([FavoritList]?)->()) {
        
        let db = Firestore.firestore()
        
        db.collection("userList").document("\(uuid)").collection("favoriList").getDocuments { snapshot, error in
            
            if error != nil {
                completion(nil)
            }
            
            else {
                
               
                    
                    
                    for document in (snapshot?.documents)! {
                                       if let animalAdvertUid = document.documentID as? String {
                                           
                                                                                          
                                           if let animalImage = document.get("animalImage") as? String{
                                                   
                                  if let animalName = document.get("animalName") as? String {
                              
                                                       if let animalAge = document.get("animalAge") as? Int {
                                 if let animalGenus = document.get("animalGenus") as? String {
                                                               if let animalSick = document.get("animalSick") as? String {
                                        if let animalKinds = document.get("animalKinds") as? String {
                    
                                            if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                                                
                                                
                                                if let animalSickInfo = document.get("animalSickInfo") as? String {
                                                    
                                                    if let userName = document.get("userName") as? String {
                                                        if let userId = document.get("userId") as? String {
                                                            
                                                            if let animalImageDetails = document.get("animalImageDetails") as? [String] {
                                                                
                                                                
                                                            let favoriteAdvert = FavoritList(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: animalImageDetails)
                                                                
                                                                self.favoriAdvertList.append(favoriteAdvert)
                                                                completion(self.favoriAdvertList)
                                                                
                                                                
                                                                
                                                            }
                                                        }
                                                            
                                                         
                                                            
                                                           
                                                            
                                                        }
                                                    }
                    
                                                }
                                                
                                            }
                          
                                  
                                     }}}}   } }
                  
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            
        }
        
    }
    
    
    func removeFavoriAdvert(advertId:String) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
    
        print("pandacık \(userId) --- \(advertId)")
        if let userId = userId {
 db.collection("userList").document(userId).collection("favoriList").document(advertId).delete()
            
            
        }
    }
    
    func dowlandAnimalAdvertDateShortFromFirestore (shortType:Bool,completion: @escaping ([AnimalAdvert]?)->()) {
        
        let db = Firestore.firestore()
        animalAdvertList = [AnimalAdvert]()
        
        db.collection("animalAdvert").order(by: "date", descending: shortType).getDocuments { snapshot, error in
            
            if error != nil {
                print("Max to min error ")
            }
            
            else {
                for document in (snapshot?.documents)! {
                                   if let animalAdvertUid = document.documentID as? String {
                                       if let animalImage =  document.get("animalImage") as? String {
                                           
                                   
                                               
                              if let animalName = document.get("animalName") as? String {
                                                   if let animalAge = document.get("animalAge") as? Int {
                             if let animalGenus = document.get("animalGenus") as? String {
                                                           if let animalSick = document.get("animalSick") as? String {
                                    if let animalKinds = document.get("animalKinds") as? String {
                
                                        if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                                            
                                            
                                            if let animalSickInfo = document.get("animalSickInfo") as? String {
                                                
                                                if let userName = document.get("userName") as? String {
                                                    if let userId = document.get("userId") as? String {
                                                        
                                                        if let imageDetails = document.get("animalImageDetails") as? [String] {
                                                            let date = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                            let animalAdvert = AnimalAdvert(userId: userId, userName: userName, animalUid: animalAdvertUid, animalImage: animalImage, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot, animalSickInfo: animalSickInfo, imageDetails: imageDetails,dateEvent: date)
                                                            
                                                            self.animalAdvertList.append(animalAdvert)
                                                            
                                                            completion(self.animalAdvertList)
                                                            
                                                        }
                                                        
                                                    }
                                                }
                
                                            }
                                            
                                        }
                      
                                        completion (self.animalAdvertList)
                                 }}}}   } }}}


                
            }
        
        }
        
        
    }
    
    

    
    
    
    
}

