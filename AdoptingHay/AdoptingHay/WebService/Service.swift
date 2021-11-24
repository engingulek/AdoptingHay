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
    
    
    func dowlandAnimalKindsFromFirestore(completion: @escaping ([AnimalKinds]?)->()) {
        let db = Firestore.firestore()
        db.collection("animalKinds").getDocuments { snapshot, error in
            if error != nil{
               // print("Hata\(error?.localizedDescription)" ?? "Hata Oluştu")
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

                                print("Oldu aga ve \(self.animalKindsList)")
                                
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
                            
                            let imageUrl = URL(string: "\(animalImage)")!
             if let animalImageData = try?  Data(contentsOf: imageUrl) {
                                
               if let animalName = document.get("animalName") as? String {
                                    if let animalAge = document.get("animalAge") as? Int {
              if let animalGenus = document.get("animalGenus") as? String {
                                            if let animalSick = document.get("animalSick") as? String {
                     if let animalKinds = document.get("animalKinds") as? String {
                         
                         if let animalAdvertOwnerNot = document.get("animalOwnerNot") as? String {
                             let animalAdvert = AnimalAdvert(animalUid: animalAdvertUid, animalImage: animalImageData, animalName: animalName, animalKinds: animalKinds, animalAge: animalAge, animalSick: animalSick, animalGenus: animalGenus, animalOwnerNot: animalAdvertOwnerNot)
                             
                             self.animalAdvertList.append(animalAdvert)
                             
                             completion(self.animalAdvertList)
                         }
       
                         completion (self.animalAdvertList)
                  }}}}   } }}}} }
           
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
                                            
                                            let animalAdvertDetails = AnimalAdvertDetails(animalUid: uuid, animalName: getAnimalName, animalKinds: getAnimalKinds, animalAge: getAnimalAge, animalSick: getAnimalSick, animalGenus: getAnimalGenus, animalOwnerNot: getAnimalOwnerNote)
                                            
                                            
                                            completion(animalAdvertDetails)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                       }
                                  }
                            }}
                        
                        
                          }
                    
                  
                    
                   }}
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

