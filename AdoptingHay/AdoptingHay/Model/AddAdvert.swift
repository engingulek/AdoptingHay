//
//  AddAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 25.11.2021.
//

import Foundation

class AddAdvert {
    var uuid:String?
    var animalName:String?
    var animalKinds:String?
    var animalAge:Int?
    var animalSick:String?
    var animalGenus:String?
    var animalOwnerNot: String?
    var animalImage : String?
    var animalImageDetails: [String]?
    
    init(uuid:String,animalName:String,animalKinds:String,animalAge:Int,animalSick:String,animalGenus:String,animalOwnerNot: String,animalImageDetails:[String],animalImage:String){
       
        self.uuid = uuid
        self.animalName = animalName
        self.animalKinds = animalKinds
        self.animalSick = animalSick
        self.animalAge = animalAge
        self.animalGenus = animalGenus
        self.animalOwnerNot = animalOwnerNot
        self.animalImageDetails = animalImageDetails
        self.animalImage = animalImage
        
    }
}


