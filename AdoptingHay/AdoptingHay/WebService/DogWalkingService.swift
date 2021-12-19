//
//  DogWalkingService.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import Foundation
import Firebase
class DogWalkingService {
    var dogWalkingAdvertList = [DogwalkingAdvert]()
    
    // Connet Firebase DogWalkingAdvert 
func geDogWalkingAdvert(completion: @escaping ([DogwalkingAdvert]?)->()){
        let db = Firestore.firestore()
        
        db.collection("dogWalkingAdvert").getDocuments { snapshot, error in
            if error != nil{
                completion(nil)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let advertId = document.documentID as? String {
                        print("dsad \(advertId)")
                        if let animalName = document.get("animalName") as? String {
                            if let animalKindsAge = document.get("ageAndGenus") as? String {
                                if let hoursRange = document.get("timeRange") as? String {
                                    
                                    if let sickInfo = document.get("sickInfo") as? String {
                                        
                                        if let animalImage = document.get("animalImage") as? String {
                                            
                                                if let ownerNote = document.get("ownerNote") as? String {
                                                    if let sickBool = document.get("sickBool") as? String {
                                                        if let userName = document.get("userName") as? String {
                                                            if let userId = document.get("userId") as? String {
                                                                let dogWalkingAdvert = DogwalkingAdvert(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool,ownerNote: ownerNote,sickInfo: sickInfo,userId: userId,userName: userName)
                                                                self.dogWalkingAdvertList.append(dogWalkingAdvert)
                                                                completion(self.dogWalkingAdvertList)
                                                                
                                                            }
                                                        }
                                                  
                                                        
                                                    } } }}} }}}}}}}
    
    
    
    // Add advert to Firebase
    func addDogWalkingAdvert(getAdvert:DogwalkingAdvert) {
        let db = Firestore.firestore()
        let docData : [String:Any] = [
            "animalImage" : getAdvert.advertImage!,
            "animalName" : getAdvert.advertAnimalName!,
            "timeRange": getAdvert.advertRange!,
            "sickBool" : getAdvert.advertAnimalSick!,
            "ageAndGenus" : getAdvert.advertAnimalKindsandAge!,
            "ownerNote" : getAdvert.ownerNote!,
            "sickInfo":getAdvert.sickInfo!,
            "userName" : getAdvert.userName!,
            "userId" : getAdvert.userId!
        
        ]
        
        if let userId = Auth.auth().currentUser?.uid {
        
            db.collection("userList").document(userId).collection("dogWalklingFavoriList").document(getAdvert.advertId!).setData(docData)
            
            
           
            
        }
        
    
    }
    
    // add advert my Favori List
    func addDogWalkingAdvertToFirebase(advert:DogWalkAddAdvert){
        let db = Firestore.firestore()
        if let userId = Auth.auth().currentUser?.uid {
            if let userName = Auth.auth().currentUser?.displayName {
                let docData : [String:Any] = [
                    "userId" : userId,
                    "userName" : userName,
                    "animalName" : advert.animalName!,
                    "ageAndGenus" : advert.ageAndGenus!,
                    "sickInfo" : advert.sickInfo!,
                    "sickBool" : advert.sickBool!,
                    "ownerNote" : advert.ownerNote!,
                    "animalImage" : advert.addImage!,
                    "date" : advert.time!,
                    "timeRange": advert.timeRange!,
                ]
                
                let advertId = UUID()
                
                db.collection("dogWalkingAdvert").document("\(advertId)").setData(docData)
                db.collection("userList").document(userId).collection("dogWalkingAdvert").document("\(advertId)").setData(docData)
                
            }
       
            
        }

        
        
    }
    
    
    
    func dowloandDogWalkingFavList(completion: @escaping ([DogwalkingAdvert]?)->()){
        
        let db = Firestore.firestore()
        if let authId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authId).collection("dogWalklingFavoriList").getDocuments { snapshot, error in
                if error != nil{
                    completion(nil)
                }
                else {
                    for document in (snapshot?.documents)! {
                        if let advertId = document.documentID as? String {
                       
                            if let animalName = document.get("animalName") as? String {
                                if let animalKindsAge = document.get("ageAndGenus") as? String {
                                    if let hoursRange = document.get("timeRange") as? String {
                                        
                                        if let sickInfo = document.get("sickInfo") as? String {
                                            
                                            if let animalImage = document.get("animalImage") as? String {
                                                
                                                    if let ownerNote = document.get("ownerNote") as? String {
                                                        if let sickBool = document.get("sickBool") as? String {
                                                            if let userName = document.get("userName") as? String {
                                                                if let userId = document.get("userId") as? String {
                                                                    let dogWalkingAdvert = DogwalkingAdvert(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool,ownerNote: ownerNote,sickInfo: sickInfo,userId: userId,userName: userName)
                                                                    self.dogWalkingAdvertList.append(dogWalkingAdvert)
                                                                    completion(self.dogWalkingAdvertList)
                                                                    
                                                                }
                                                            }
                                                      
                                                            
                                                        } } }}} }}}}}}
            
        }
       
        
        
        
    }
    
    
    func removeFavoriAdvert(advertId:String) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        
 
        if let userId = userId {
            db.collection("userList").document(userId).collection("dogWalklingFavoriList").document(advertId).delete()
            
            
        }
    }
    
    
    

}
