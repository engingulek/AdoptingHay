//
//  MyAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.12.2021.
//

import Foundation

class MyAdvert {
    var userid:String?
    var userName:String?
    var animaluuid : String?
    var animalName:String?
    var animalKinds:String?
    var animalAge:Int?
    var animalSickInfo:String?
    var animalGenus:String?
    var animalOwnerNot: String?
    var animalImage : String?
    var animalImageDetails: [String]?
    var animalSickBool:String?
    
    
    init(userName:String,userid:String,animalName:String,animalKinds:String,animalAge:Int,animalSickInfo:String,animalGenus:String,animalOwnerNot: String,animalImageDetails:[String],animalImage:String,animalSickBool:String,animaluuid:String){
       
        self.userid = userid
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
        self.animaluuid = animaluuid
    }
    
}
