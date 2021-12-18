//
//  MessageModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 13.12.2021.
//

import Foundation


class MessageModel{
    var sendMessage:String?
    var sendUserId:String?
    
    init(sendMessage:String,sendUserId:String){
        self.sendMessage = sendMessage
        self.sendUserId = sendUserId
        
    }
    
}
