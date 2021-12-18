//
//  DogWalkingAdvertsViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import Foundation


struct  DogWalkingListViewModel {
    let dogWalkingAdvertList : [DogwalkingAdvert]
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
    
    var image:Data {
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
}
