//
//  MessageViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 13.12.2021.
//

import Foundation
struct MessageViewModelList {
    let messageList : [MessageModel]
    
    func messageCount() -> Int {
        return self.messageList.count
    }
    
    func messageDataList() -> [MessageModel] {
       
        return messageList
        
    }
}


struct MessageViewModel {
    let messageList : MessageModel
    
    var message : String {
        return self.messageList.sendMessage!
    }
    
    var userId : String {
        return self.messageList.sendUserId!
    }
}



