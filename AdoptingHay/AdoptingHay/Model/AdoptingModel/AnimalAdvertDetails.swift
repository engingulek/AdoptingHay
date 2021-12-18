//
//  AnimalAdvertDetails.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.11.2021.
//

import Foundation



class AnimalAdvertDetails  {
    var animalUid:String?
    
    // List cinsinde olacak
   // var animalImage:Data?
    var animalName:String?
    var animalKinds:String?
    var animalAge:Int?
    var animalSick:String?
    var animalGenus:String?
    var animalOwnerNot: String?
    var animalImageDetails: [String]?
    var animalSickInfo: String?
    


    init(animalUid:String,animalName:String,animalKinds:String,animalAge:Int,animalSick:String,animalGenus:String,animalOwnerNot: String,animalImageDetails:[String],animalSickInfo: String){
        self.animalUid = animalUid
 
        self.animalName = animalName
        self.animalKinds = animalKinds
        self.animalSick = animalSick
        self.animalAge = animalAge
        self.animalGenus = animalGenus
        self.animalOwnerNot = animalOwnerNot
        self.animalImageDetails = animalImageDetails
        self.animalSickInfo = animalSickInfo
        
    }

    
}
