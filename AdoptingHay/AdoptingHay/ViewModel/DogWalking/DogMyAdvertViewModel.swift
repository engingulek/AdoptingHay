//
//  DogMyAdvertViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 20.12.2021.
//

import Foundation

struct  DogMyAdvertListViewModel {
    var dogMyAdvertListViewModel : [DogMyAdvert]
    func numberOfRowsInSection() -> Int {
        return self.dogMyAdvertListViewModel.count
    }
    func animalKindsAtIndex(_ index: Int) ->  DogMyAdvertViewModel {
       
        let advert = self.dogMyAdvertListViewModel[index]
        return DogMyAdvertViewModel(dogmyAdvert: advert)
        
    }
}

struct DogMyAdvertViewModel {
    let dogmyAdvert : DogMyAdvert
    
    var advertId : String {
        return self.dogmyAdvert.advertId!
    }
    
    var image:String {
        return self.dogmyAdvert.animalImage!
    }
    
    var range:Int {
        return self.dogmyAdvert.timeRange!
    }
    
    
    var name:String {
        return self.dogmyAdvert.animalName!
    }

    var genusAndAge:String{
        return self.dogmyAdvert.ageAndGenus!
    }
    
    var sick:String{
        return self.dogmyAdvert.sickBool!
    }
    var sickInfo: String {
        return self.dogmyAdvert.sickInfo!
    }
    
    var ownerNote: String {
        return self.dogmyAdvert.ownerNote!
    }
    var userName:String {
        return self.dogmyAdvert.userName!
    }
    
    var userId:String{
        return self.dogmyAdvert.userId!
    }
    var situation:String {
        return self.dogmyAdvert.situation!
    }
    
    
    var addDate : String {
        
        var dateString : String {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
            formatter.dateFormat = "dd/MMMM/yyyy"
            return formatter.string(from: dogmyAdvert.time!)
        }
        return dateString
        
        
    }
}

