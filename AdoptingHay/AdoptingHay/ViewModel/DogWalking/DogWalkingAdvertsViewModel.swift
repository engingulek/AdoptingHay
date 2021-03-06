//
//  DogWalkingAdvertsViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import Foundation


struct  DogWalkingListViewModel {
    var dogWalkingAdvertList : [DogwalkingAdvert]
    func numberOfRowsInSection() -> Int {
        return self.dogWalkingAdvertList.count
    }
    func animalKindsAtIndex(_ index: Int) -> DogWalKingViewModel {
       
        let advert = self.dogWalkingAdvertList[index]
        return DogWalKingViewModel(dogWalkingAdvert: advert)
        
    }
}

struct DogWalKingViewModel {
    let dogWalkingAdvert : DogwalkingAdvert
    
    var id : String {
        return self.dogWalkingAdvert.advertId!
    }
    
    var image:String {
        return self.dogWalkingAdvert.advertImage!
    }
    
    var range:Int {
        return self.dogWalkingAdvert.advertRange!
    }
    
    
    var name:String {
        return self.dogWalkingAdvert.advertAnimalName!
    }

    var kindsAndAge:String{
        return self.dogWalkingAdvert.advertAnimalKindsandAge!
    }
    
    var sick:String{
        return self.dogWalkingAdvert.advertAnimalSick!
    }
    var sickInfo: String {
        return self.dogWalkingAdvert.sickInfo!
    }
    
    var ownerNote: String {
        return self.dogWalkingAdvert.ownerNote!
    }
    var userName:String {
        return self.dogWalkingAdvert.userName!
    }
    
    var userId:String{
        return self.dogWalkingAdvert.userId!
    }
    
    var addDate : String {
        
        var dateString : String {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
            formatter.dateFormat = "dd/MMMM/yyyy"
            return formatter.string(from: dogWalkingAdvert.dateEvent!)
        }
        return dateString
        
        
    }
    
    var situation : String {
        return self.dogWalkingAdvert.situation!
    }
}
