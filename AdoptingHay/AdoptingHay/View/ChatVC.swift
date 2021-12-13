import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase


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
    private var sendSender = Sender(senderId: "2", displayName: "Selin Çiçek")
    var messageViewModelList : MessageViewModelList!
 
    var senderName:String?


    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
     
        
   
        
        
        getAll()
        
        
      
            
           
            
        }
    
    func getAll() {
        let db = Firestore.firestore()
    
        
        if let authUserID = Auth.auth().currentUser?.uid {
            
            db.collection("userList").document(authUserID).collection("conversation").getDocuments { snasphot, error in
                if error != nil {
                    print("Message getAll error \(error?.localizedDescription)")
                }
                
                else {
                    
                    for document in (snasphot?.documents)! {
                        print("Messsge sender id : \(document.documentID)")
                        if let messageSenderName = document.get("kullanıcıName") as? String {
                            print("Message sender name \(messageSenderName)")
                            self.navigationItem.title = messageSenderName
                            
                            if let message = document.get("message") as? [Any]
                            {
                                
                            
                                
                                for i in 0...message.count-1 {
                                    print("\(i). sıra \(message[i])")
                                    
                                    if let messageOrder = message[i] as? [String:Any] {
                                        
                                        
                                        
                                        if let gonderilenMessage = messageOrder["gonderilenMessage"] as? String {
                                            
                                            if let sendUserID = messageOrder["senderId"] as? String {
                                                
                                                print("USER ID : \(Auth.auth().currentUser?.uid)")
                                                
                                                if let userId = Auth.auth().currentUser?.uid as? String {
                                                    if userId == sendUserID {
                                                        self.messages.append(Message(sender: self.selfSender, messageId: "1", sentDate: Date(), kind: .text(gonderilenMessage)))
                                                        
                                                    }
                                                    else {
                                                        self.messages.append(Message(sender: self.sendSender, messageId: "2", sentDate: Date(), kind: .text(gonderilenMessage)))
                                                        
                                                    }
                                                    
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
            }

        
    }
    
  
    
 
    

                
        
        
       
       
       
      
        
    
       
    }
   
    
 
     
            
   
        
        
    
    
    
    
    
    
    
    




extension ChatVC : InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//       self.messages.removeAll()
        
//        Service().sendMessage(sendUserId: (getAnimalAdvert?.userId)!, sendUserName: (getAnimalAdvert?.userName)!, sendMessage: mesajText.text!)
    
    
     
     
      // getAll()

//        print("\(text)")
      
    }
}







extension ChatVC :  MessagesDataSource ,MessagesLayoutDelegate, MessagesDisplayDelegate {
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
            avatarView.image = UIImage(named: "bird")
        }
        else {
            avatarView.image = UIImage(named: "dog")
        }
    }
}
