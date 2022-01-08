//
//  Notification.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.10.2021.
//

import Foundation

class Notification {
 
    var getUserId : String?
    var sendMessage:String?
    var sendNotiSubtitle:String?
    var sendNotiTitle:String?
    var sendUserName:String?
    var notiId : String?

    
    
    
    init(getUserId : String, sendMessage:String,sendNotiSubtitle:String,sendNotiTitle:String,sendUserName:String, notiId : String){
        self.getUserId = getUserId
        self.sendMessage = sendMessage
        self.sendNotiSubtitle = sendNotiSubtitle
        self.sendNotiTitle = sendNotiTitle
        self.sendUserName = sendUserName
        self.notiId = notiId

        
    }
    
}
