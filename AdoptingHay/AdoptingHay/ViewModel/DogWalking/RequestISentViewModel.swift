//
//  RequestISentViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import Foundation

struct RequestInSentViewModelList {
    var isentList : [DogwalkingAdvert]
    
    func insentListListCount() -> Int {
        return isentList.count
    }
    
    func insentRequestAtIndex(_ index:Int) -> RequestISentViewModel {
        let isent = isentList[index]
        
        return RequestISentViewModel(isentRequest : isent)
        
    }
}


struct RequestISentViewModel {
    let isentRequest : DogwalkingAdvert
    
    var id : String {
        return self.isentRequest.advertId!
    }
    
    var image:String {
        return self.isentRequest.advertImage!
    }
    
    var range:Int {
        return self.isentRequest.advertRange!
    }
    
    
    var name:String {
        return self.isentRequest.advertAnimalName!
    }

    var kindsAndAge:String{
        return self.isentRequest.advertAnimalKindsandAge!
    }
    
    var sick:String{
        return self.isentRequest.advertAnimalSick!
    }
    var sickInfo: String {
        return self.isentRequest.sickInfo!
    }
    
    var ownerNote: String {
        return self.isentRequest.ownerNote!
    }
    var userName:String {
        return self.isentRequest.userName!
    }
    
    var userId:String{
        return self.isentRequest.userId!
    }
    
    var addDate : String {
        
        var dateString : String {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
            formatter.dateFormat = "dd/MMMM/yyyy"
            return formatter.string(from: isentRequest.dateEvent!)
        }
        return dateString
        
        
    }
    
    var situation : String {
        return self.isentRequest.situation!
    }
    
 
}


