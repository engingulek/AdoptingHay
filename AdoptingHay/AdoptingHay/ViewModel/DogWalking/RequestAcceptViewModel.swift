import Foundation



struct RequestAcceptViewModel{
    let requestAccept : Request
    
    var id : String {
        return self.requestAccept.advertId!
    }
    
    var image:String {
        return self.requestAccept.advertImage!
    }
    
    var range:Int {
        return self.requestAccept.advertRange!
    }
    
    
    var name:String {
        return self.requestAccept.advertAnimalName!
    }

    var kindsAndAge:String{
        return self.requestAccept.advertAnimalKindsandAge!
    }
    
    var sick:String{
        return self.requestAccept.advertAnimalSick!
    }
    var sickInfo: String {
        return self.requestAccept.sickInfo!
    }
    
    var ownerNote: String {
        return self.requestAccept.ownerNote!
    }
    var userName:String {
        return self.requestAccept.userName!
    }
    
    var userId:String{
        return self.requestAccept.userId!
    }
    
    var addDate : String {
        
        var dateString : String {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
            formatter.dateFormat = "dd/MMMM/yyyy"
            return formatter.string(from: requestAccept.dateEvent!)
        }
        return dateString
        
        
    }
    
    var situation : String {
        return self.requestAccept.situation!
    }
    
    var sendId: String {
        return self.requestAccept.sendId!
    }
    
    var acceptUserName : String {
        return self.requestAccept.acceptUserName!
        
    }
    
 
}


