//
//  DogChatVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.12.2021.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase


struct DogMessage : MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
}


struct DogSender:SenderType {
   
    var senderId: String
    var displayName: String
    
    
    
    
    
}

class DogChatVC: MessagesViewController {
    private var messages = [Message]()
    var userId:String?
    private var selfSender = Sender(senderId: "1", displayName: "Engin Gülek")
    private var sendSender = Sender(senderId: "2", displayName: "Selin Çiçek")
    var messageViewModelList : MessageViewModelList!
    var timer = Timer()
    var  messageGetUserName : String?
    var senderName:String?
    var sendToGetMessageDataChat:[String:Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        self.getAllMessageData()
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    self.getAllMessageData()
                })
    

        
    }
    
    
    
    func ada(document:QueryDocumentSnapshot,id:String) {
        let db = Firestore.firestore()
        if id == document.documentID {
            if let messageSenderName = document.get("getUserName") as? String {
                                        print("Message sender name \(messageSenderName)")
                self.messageGetUserName = messageSenderName
                                        self.navigationItem.title = messageSenderName
                                        
                                        if let message = document.get("message") as? [Any]
                                        {
                                            
                                        
                                            
                                            for i in 0...message.count-1 {
                                                print("\(i). sıra \(message[i])")
                                                
                                                if let messageOrder = message[i] as? [String:Any] {
                                                    
                                                    
                                                    
                                                    if let gonderilenMessage = messageOrder["sendMessage"] as? String {
                                                        
                                                        if let sendUserID = messageOrder["senderId"] as? String {
                                                            
                                                            print("USER ID : \(Auth.auth().currentUser?.uid)")
                                                            
                                                            if let userId = Auth.auth().currentUser?.uid as? String {
                                                                if userId == sendUserID {
                                                                    self.messages.append(Message(sender: self.selfSender, messageId: "1", sentDate: Date(), kind: .text(gonderilenMessage)))
                                                                    
                                                                }
                                                                else {
                                                                    self.messages.append(Message(sender: self.sendSender, messageId: "2", sentDate: Date(), kind: .text(gonderilenMessage)))
                                                                    
                                                                }
                                                                self.messagesCollectionView.reloadData()
                                                                
                                                            }
                                                            
                                                            
                                                            
                                                            
                                                          
                                                         
                                                        }
                                                        
                                                    }
                                                }
                                            
                                                
                                            
                                                
                                                
                                            }
                                  
                                                
                                            }
                                        }

            
        }
        
        
    }
    
    
    func getAllMessageData() {
        self.messages.removeAll()
        let db = Firestore.firestore()
    
        
        if let authUserID = Auth.auth().currentUser?.uid {
            
            db.collection("userList").document(authUserID).collection("dogWalkingConversation").getDocuments { snasphot, error in
                if error != nil {
                    print("Message getAll error \(error?.localizedDescription)")
                }
                
                else {
                   
                    
                    
                    for document in (snasphot?.documents)! {
                        
                       
                        
                        
                        if let sendUserId = self.userId {
                            self.ada(document: document, id: sendUserId)
                            }
                        
                        
                        else {
                            if let senderUserId = self.sendToGetMessageDataChat!["messageGetUserId"] as? String {
                                
                                self.ada(document: document, id: senderUserId)
                           

                                
                            }
                        }

                        }
                        
                        
                    }
                }
            }

        
    }

   

}



extension DogChatVC : InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        if let sendUserId = userId as? String {
           
         
            self.messagesCollectionView.reloadData()
            if let sendUserName = Auth.auth().currentUser?.displayName as? String {
            
                                DogWalkingService().sendMessage(sendUserId: sendUserId , sendUserName: sendUserName, sendMessage: text,getUserName:self.messageGetUserName!)
               inputBar.inputTextView.text = ""
                
                
            }
            
        
        }
        else {
            


            if let senduserid = self.sendToGetMessageDataChat!["messageGetUserId"] as? String {
              
                self.messagesCollectionView.reloadData()
                if let sendUserName =  Auth.auth().currentUser?.displayName as? String {
                    
                    if let messageGetuserName = self.sendToGetMessageDataChat!["messageGetUserName"] as? String {
                        
                        DogWalkingService().sendMessage(sendUserId: senduserid , sendUserName: sendUserName, sendMessage: text,getUserName: messageGetuserName)
            inputBar.inputTextView.text = ""
                        
                    }
                    
        
                    
                    
                }
 
                
            }
            
            
            
 
            
        }
        
        
        
    }
    
}


extension DogChatVC :  MessagesDataSource ,MessagesLayoutDelegate, MessagesDisplayDelegate {
   
    
    func currentSender() -> SenderType {
      return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
       
        return  messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        print("Message sayi \(messages.count)")
        return messages.count
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender
        if sender.senderId == selfSender.senderId {
            // our image
            avatarView.image = UIImage(named: "red")
        }
        else {
            avatarView.image = UIImage(named: "blue")
        }
    }
    
    
}
