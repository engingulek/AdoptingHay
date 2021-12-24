//
//  DogWalkingAdvertFav.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.12.2021.
//

import Foundation
import Foundation


struct  DogWalkingFavListViewModel {
    var dogFavAdvertList : [DogFavAdvert]
    func numberOfRowsInSection() -> Int {
        return self.dogFavAdvertList.count
    }
    func animalKindsAtIndex(_ index: Int) -> DogWalKingFavViewModel {
       
        var advert = self.dogFavAdvertList[index]
        return DogWalKingFavViewModel(dogFavAdvert: advert)
        
    }
}

struct DogWalKingFavViewModel {
    let dogFavAdvert : DogFavAdvert
    
   
    
    var image:String {
        return self.dogFavAdvert.animalImage!
    }
    
    var range:Int {
        return self.dogFavAdvert.timeRange!
    }
    
    
    var name:String {
        return self.dogFavAdvert.animalName!
    }

    var kindsAndAge:String{
        return self.dogFavAdvert.ageAndGenus!
    }
    
    var sick:String{
        return self.dogFavAdvert.sickBool!
    }
    var sickInfo: String {
        return self.dogFavAdvert.sickInfo!
    }
    
    var ownerNote: String {
        return self.dogFavAdvert.ownerNote!
    }
    var userName:String {
        return self.dogFavAdvert.userName!
    }
    
    var userId:String{
        return self.dogFavAdvert.userId!
    }
    var advertId:String {
        return self.dogFavAdvert.advertId!
    }
    
    var addDate : String {
        
        var dateString : String {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
            formatter.dateFormat = "dd/MMMM/yyyy"
            return formatter.string(from: dogFavAdvert.time!)
        }
        return dateString
        
        
    }
    
    var situation : String {
        return self.dogFavAdvert.situation!
    }
    
}
