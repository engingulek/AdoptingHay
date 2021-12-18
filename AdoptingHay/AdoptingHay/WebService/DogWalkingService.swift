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
    
    
func geDogWalkingAdvert(completion: @escaping ([DogwalkingAdvert]?)->()){
        let db = Firestore.firestore()
        
        db.collection("dogWalkingAdvert").getDocuments { snapshot, error in
            if error != nil{
                completion(nil)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let advertId = document.documentID as? String {
                        if let animalName = document.get("animalName") as? String {
                            if let animalKindsAge = document.get("animalKindsAge") as? String {
                                if let hoursRange = document.get("hoursRange") as? String {
                                    
                                    if let animaSick = document.get("animaSick") as? String {
                                        
                                        if let animalImage = document.get("animalImage") as? String {
                                            let imageUrl = URL(string: "\(animalImage)")!
                                            
                                            if let imageData = try?  Data(contentsOf: imageUrl) {
                                                let dogWalkingAdvert = DogwalkingAdvert(advertId: advertId, advertImage: imageData, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: animaSick)
                                                self.dogWalkingAdvertList.append(dogWalkingAdvert)
                                                completion(self.dogWalkingAdvertList)
                                                
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
