//
//  Message.swift
//  AdoptingHay
//
//  Created by engin gülek on 13.12.2021.
//

import Foundation

struct Message  {

    var senderId:String
    var messageId: String
    
    var sentDate: Date
    
    var messageText: String
    
    
    init(messageId:String,kind:String,sentDate: Date,senderId:String,messageText: String){
        self.senderId = senderId
        self.messageId = messageId
        self.messageText = messageText
        self.sentDate = sentDate
    }
    
    
    
  
}
