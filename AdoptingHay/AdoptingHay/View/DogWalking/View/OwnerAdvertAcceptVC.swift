import UIKit
import Firebase
class OwnerAdvertAcceptVC: UIViewController {
    private var commingRequestAccept : RequestAcceptViewModel!
    var dogWalkingtimer:Timer = Timer()
    var count:Int?
    var timerCounting:Bool = false
    var timerLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 100))
    var finishButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        getAcceptAdvert()
       
    
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        getAcceptAdvert()
    }
    
    
    @objc  func timerCounter()-> Void {
        if count == 0 {
            finishButton.setTitle("Bitir", for: UIControl.State.normal)
            
        }
        
        else {
            count = count! - 1
            let time = secondsToHoursMinutesSeconds(seconds: count!)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            self.timerLabel.text = timeString
           
            
        }
     
    }
    
    
 func secondsToHoursMinutesSeconds(seconds:Int) -> (Int,Int,Int) {
        return  ((seconds / 3600),((seconds % 3600)/60), ((seconds % 3600)%60))
    }
    
    func makeTimeString(hours:Int,minutes:Int,seconds:Int) -> String {
        var timeStirng = ""
        timeStirng += String(format: "%2d", hours)
        timeStirng += ":"
        timeStirng += String(format: "%2d", minutes)
        timeStirng += ":"
        timeStirng += String(format: "%2d", seconds)
        return timeStirng
        
        
        
    }
    
    
    
    func getAcceptAdvert() {
        DogWalkingService().getAcceptAdvert(collectionName: "comingAcceptAdvert") { request in
            if let request = request {
                self.commingRequestAccept = RequestAcceptViewModel(requestAccept: request)
               // süre self.commingRequestAccept.range*60
                self.count = 5
                let time = self.secondsToHoursMinutesSeconds(seconds: self.count!)
                let timeString = self.makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
                self.timerLabel.text = timeString
              
                
                if self.commingRequestAccept == nil {
                    var requestNilTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
                   
                    requestNilTitleLabel.text = "Kabul edilen bir ilan bulunmamaktadır"
                    requestNilTitleLabel.textAlignment = .center
                    requestNilTitleLabel.center.x = self.view.center.x
                    requestNilTitleLabel.center.y = self.view.center.y
                    requestNilTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                    requestNilTitleLabel.textColor = .black
                    requestNilTitleLabel.numberOfLines = 2
                    self.view.addSubview(requestNilTitleLabel)
     
                    
                    
                }
                else {
            
                    self.acceptToRequestDesign()
                    
                }
            }
            
        }
    }
    
    
    
  

    func acceptToRequestDesign() {
        let  timerTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        timerTitleLabel.text = "Kalan Süre"
        timerTitleLabel.textAlignment = .center
        timerTitleLabel.center.x = self.view.center.x
        timerTitleLabel.center.y = self.view.center.y/3
        timerTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        timerTitleLabel.textColor = .black
        self.view.addSubview(timerTitleLabel)
        
   
        
      
       
        timerLabel.textAlignment = .center
        timerLabel.center.x = self.view.center.x
        timerLabel.center.y = self.view.center.y/2
        timerLabel.font = UIFont.systemFont(ofSize: 55,weight: .regular)
        timerLabel.textColor = .red
        self.view.addSubview(timerLabel)
        
        

        
        

        
        
        
        let amountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        let amount = (self.commingRequestAccept.range/30)*50
        amountLabel .text = "Ücret: \(amount)"
        amountLabel .textAlignment = .center
        amountLabel .center.x = self.view.center.x
        amountLabel .center.y =  timerLabel.center.y + 50
        amountLabel .font = UIFont.systemFont(ofSize: 25, weight: .medium)
        amountLabel .textColor = .black
        self.view.addSubview(amountLabel)
        
    
        
        let animalName = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        animalName.text = "Adı: \(self.commingRequestAccept.name) "
        animalName.textAlignment = .center
        animalName.center.x = self.view.center.x
        animalName.center.y = amountLabel.center.y + 50
        animalName.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        animalName.textColor = .black
        self.view.addSubview(animalName)
        
        let sickInfoTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        sickInfoTitle.text = "Hastalık Bilgi"
        sickInfoTitle.textAlignment = .center
        sickInfoTitle.center.x = self.view.center.x
        sickInfoTitle.center.y =  animalName.center.y + 50
        sickInfoTitle.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        sickInfoTitle.textColor = .black
        self.view.addSubview(sickInfoTitle)

        if self.commingRequestAccept.sick == "Yok" {
            let sickInfo = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
            sickInfo.text = "Yok"
            sickInfo.textAlignment = .center
            sickInfo.center.x = self.view.center.x
            sickInfo.center.y =  sickInfoTitle.center.y + 50
            sickInfo.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            sickInfo.textColor = .black
            self.view.addSubview(sickInfo)

        }

        else {
            let sickInfoA = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
            sickInfoA.backgroundColor = .systemGray5
            sickInfoA.text = self.commingRequestAccept.sickInfo
            sickInfoA.textAlignment = .center
            sickInfoA.isUserInteractionEnabled = false
            sickInfoA.center.x = self.view.center.x
            sickInfoA.font = UIFont.systemFont(ofSize: 17)
            sickInfoA.center.y =  sickInfoTitle.center.y + 80
            self.view.addSubview(sickInfoA)

        }
        
        
       
        finishButton.backgroundColor = .systemBlue
        finishButton.layer.cornerRadius = 15
        finishButton.titleLabel?.font = .systemFont(ofSize: 20)
        finishButton.setTitle("Başlat", for: UIControl.State.normal)
        finishButton.center.x = self.view.center.x/2
        finishButton.center.y =  sickInfoTitle.center.y + 170
        self.view.addSubview(finishButton)
        
        finishButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        
        
        
        
        let sendPhotoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        sendPhotoButton.backgroundColor = .systemRed
        sendPhotoButton.layer.cornerRadius = 15
        sendPhotoButton.titleLabel?.font = .systemFont(ofSize: 17)
        sendPhotoButton.setTitle("Mesaj Gönder", for: UIControl.State.normal)
        sendPhotoButton.center.x = self.view.center.x + 95
        sendPhotoButton.center.y =  sickInfoTitle.center.y + 170
        self.view.addSubview(sendPhotoButton)
        
        sendPhotoButton.addTarget(self, action: #selector(sendPhotoButtonAction), for: .touchUpInside)
        
    
        
    }
    
    
    @objc func sendButtonAction() {
        let db = Firestore.firestore()
        if(timerCounting) {
//            timerCounting = false
//
//
//            dogWalkingtimer.invalidate()
            
            if finishButton.currentTitle != "Başlat" {
                print("Gezdirme İşlemi Bitti")
                if let authUserId = Auth.auth().currentUser?.uid as? String {
                    if let uuid = self.commingRequestAccept.sendId as? String {
                        
                        let updateData : [String:Any] = [
                            "acceptDogWalkingBool":"finish"
                        ]
                        db.collection("userList").document(authUserId).collection("acceptDogWalking").document(uuid).updateData(updateData)
                        
                        if let advertId = self.commingRequestAccept.id as? String {
                            performSegue(withIdentifier: "comment", sender: uuid)
                            db.collection("userList").document(authUserId).collection("comingAcceptAdvert").document(advertId).delete()
                            
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                        
                  
                    }
                    
                   
                }
                
            }
            
        }
        else {
            
            
            if let authUserId = Auth.auth().currentUser?.uid as? String {
                if let uuid = self.commingRequestAccept.sendId as? String {
                    
                    let updateData : [String:Any] = [
                        "acceptDogWalkingBool":"start"
                    ]
                    db.collection("userList").document(authUserId).collection("acceptDogWalking").document(uuid).updateData(updateData)
                    
                    timerCounting = true
                    dogWalkingtimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                    print("Gezdirme İşlemi başladı")
                }
            }
            
            
         
        }
    }
    
   
    
    @objc func sendPhotoButtonAction() {
        if let id = self.commingRequestAccept.sendId as? String {
            let sendToGetMessageData : [String:Any] = [
                "messageGetUserId" : id,
                "messageGetUserName" : commingRequestAccept.acceptUserName
            
            ]
            performSegue(withIdentifier: "m", sender:sendToGetMessageData)
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "m" {
            if let data = sender as? [String:Any] {
            let toDogChatVC = segue.destination as! DogChatVC
                toDogChatVC.sendToGetMessageDataChat = data
            
        }
      
        }
        
        if segue.identifier == "comment" {
            if let userId = sender as? String {
                let toCommentVC = segue.destination as! CommentMakeVC
                toCommentVC.getUserId = userId
            }
        }
        
    }
    

}
