//
//  DogWalkingAdvertFav.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.12.2021.
//

import Foundation
import Foundation


struct  DogWalkingFavListViewModel {
    var dogWalkingAdvertFav : [DogwalkingAdvert]
    func numberOfRowsInSection() -> Int {
        return self.dogWalkingAdvertFav.count
    }
    func animalKindsAtIndex(_ index: Int) -> DogWalKingFavViewModel {
       
        var advert = self.dogWalkingAdvertFav[index]
        return DogWalKingFavViewModel(dogWalkingAdvert: advert)
        
    }
}

struct DogWalKingFavViewModel {
    let dogWalkingAdvert : DogwalkingAdvert
    
    var id : String {
        return self.dogWalkingAdvert.advertId!
    }
    
    var image:String {
        return self.dogWalkingAdvert.advertImage!
    }
    
    var range:String {
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
    var advertId:String {
        return self.dogWalkingAdvert.advertId!
    }
}
