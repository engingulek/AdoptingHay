//
//  AnimalAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.10.2021.
//

import Foundation


class AnimalAdvert  {
    var animalUid:String?
    var animalImage:String?
    var animalName:String?
    var animalKinds:String?
    var animalAge:Int?
    var animalSick:String?
    var animalGenus:String?
    var animalOwnerNot: String?
    var animalSickInfo: String?
    var userId : String?
    var userName : String?
    var imageDetails : [String]
    var dateEvent : Date
   

    


    init(userId:String,userName : String,animalUid:String,animalImage:String,animalName:String,animalKinds:String,animalAge:Int,animalSick:String,animalGenus:String,animalOwnerNot: String,animalSickInfo:String,imageDetails:[String],dateEvent:Date){
        self.animalUid = animalUid
        self.animalImage = animalImage
        self.animalName = animalName
        self.animalKinds = animalKinds
        self.animalSick = animalSick
        self.animalAge = animalAge
        self.animalGenus = animalGenus
        self.animalOwnerNot = animalOwnerNot
        self.userId = userId
        self.userName = userName
        self.animalSickInfo = animalSickInfo
        self.imageDetails = imageDetails
        self.dateEvent = dateEvent
    }

    
}

