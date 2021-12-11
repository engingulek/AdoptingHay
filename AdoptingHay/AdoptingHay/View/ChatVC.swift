//
//  ChatVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 11.12.2021.
//

import UIKit
import MessageKit


struct Message : MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
}


struct Sender:SenderType {
    var senderId: String
    var displayName: String
    
    
}

class ChatVC: MessagesViewController {
    private var messages = [Message]()
    private var selfSender = Sender(senderId: "1", displayName: "Engin Gülek")
    private var sendSender = Sender(senderId: "2", displayName: "Selin Çiçek" )

    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Merhaba")))
        messages.append(Message(sender: sendSender, messageId: "2", sentDate: Date(), kind: .text("İyi aga")))
       
    }

}


extension ChatVC :  MessagesDataSource ,MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        
      return selfSender
    
        
    
       
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
