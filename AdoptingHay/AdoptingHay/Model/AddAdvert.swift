//
//  AddAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 25.11.2021.
//

import Foundation

class AddAdvert {
    var uuid:String?
    var userName:String?
    var animalName:String?
    var animalKinds:String?
    var animalAge:Int?
    var animalSickInfo:String?
    var animalGenus:String?
    var animalOwnerNot: String?
    var animalImage : String?
    var animalImageDetails: [String]?
    var animalSickBool:String
    var date : Date
    init(userName:String,uuid:String,animalName:String,animalKinds:String,animalAge:Int,animalSickInfo:String,animalGenus:String,animalOwnerNot: String,animalImageDetails:[String],animalImage:String,animalSickBool:String,date:Date){
       
        self.uuid = uuid
        self.userName = userName
        self.animalName = animalName
        self.animalKinds = animalKinds
        self.animalSickInfo = animalSickInfo
        self.animalAge = animalAge
        self.animalGenus = animalGenus
        self.animalOwnerNot = animalOwnerNot
        self.animalImageDetails = animalImageDetails
        self.animalImage = animalImage
        self.animalSickBool = animalSickBool
        self.date = date
    }
}


