//
//  RequestViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import Foundation
//
//  DogNotificationViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 22.12.2021.
//





struct RequestInComigViewModelList {
    var incomingList : [DogwalkingAdvert]
    
    func incomingListListCount() -> Int {
        return incomingList.count
    }
    
    func incomingRequestAtIndex(_ index:Int) -> RequestInComigViewModel {
        let incoming = incomingList[index]
        
        return RequestInComigViewModel(incomingRequest: incoming)
        
    }
}


struct RequestInComigViewModel {
    let incomingRequest : DogwalkingAdvert
    
    var id : String {
        return self.incomingRequest.advertId!
    }
    
    var image:String {
        return self.incomingRequest.advertImage!
    }
    
    var range:Int {
        return self.incomingRequest.advertRange!
    }
    
    
    var name:String {
        return self.incomingRequest.advertAnimalName!
    }

    var kindsAndAge:String{
        return self.incomingRequest.advertAnimalKindsandAge!
    }
    
    var sick:String{
        return self.incomingRequest.advertAnimalSick!
    }
    var sickInfo: String {
        return self.incomingRequest.sickInfo!
    }
    
    var ownerNote: String {
        return self.incomingRequest.ownerNote!
    }
    var userName:String {
        return self.incomingRequest.userName!
    }
    
    var userId:String{
        return self.incomingRequest.userId!
    }
    
    var addDate : String {
        
        var dateString : String {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
            formatter.dateFormat = "dd/MMMM/yyyy"
            return formatter.string(from: incomingRequest.dateEvent!)
        }
        return dateString
        
        
    }
    
    var situation : String {
        return self.incomingRequest.situation!
    }
    
 
}
