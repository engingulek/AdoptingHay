//
//  MessageUserList.swift
//  AdoptingHay
//
//  Created by engin gülek on 13.12.2021.
//

import Foundation

struct MessageUserListViewModel {
    let messageUserList : [MessageUserList]
    
    func messsageUserListCount () -> Int {
        return messageUserList.count
    }
    
    func messageUserNameIndex(_ index:Int) -> MessageUserViewModel{
      
      let messagaUser = messageUserList[index]
      return MessageUserViewModel(messageUserList: messagaUser)

   }
}

struct MessageUserViewModel {
    var messageUserList : MessageUserList
    
    var name : String {
        return self.messageUserList.sendName
    }
    
    var id : String {
        return self.messageUserList.sendUserId
    }
}
