//
//  OwnerAdvertAcceptVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 26.12.2021.
//

import UIKit

class OwnerAdvertAcceptVC: UIViewController {
    private var commingRequestAccept : RequestAcceptViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        getAcceptAdvert()
       
    
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        getAcceptAdvert()
    }
    
    
    
    
    func getAcceptAdvert() {
        DogWalkingService().getAcceptAdvert(collectionName: "comingAcceptAdvert") { request in
            if let request = request {
                self.commingRequestAccept = RequestAcceptViewModel(requestAccept: request)
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
    
    
    
    func acceptRequesNilDesign(){
       
        
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
        
   
        
        let timerLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 100))
        timerLabel.text =  "01:30"
        timerLabel.textAlignment = .center
        timerLabel.center.x = self.view.center.x
        timerLabel.center.y = self.view.center.y/2
        timerLabel.font = UIFont.systemFont(ofSize: 55,weight: .regular)
        timerLabel.textColor = .red
        self.view.addSubview(timerLabel)
        
        
        let sendPhotoTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        sendPhotoTitleLabel.text = "Fotoğraf İçin Kalan Süre"
        sendPhotoTitleLabel.textAlignment = .center
        sendPhotoTitleLabel.center.x = self.view.center.x
        sendPhotoTitleLabel.center.y = self.view.center.y/1.5
        sendPhotoTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        sendPhotoTitleLabel.textColor = .black
        self.view.addSubview(sendPhotoTitleLabel)
        
        
        let sendPhotoLabelTimer =  UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 100))
        sendPhotoLabelTimer.text =  "00:30"
        sendPhotoLabelTimer.textAlignment = .center
        sendPhotoLabelTimer.center.x = self.view.center.x
        sendPhotoLabelTimer.center.y = self.view.center.y/1.2
        sendPhotoLabelTimer.font = UIFont.systemFont(ofSize: 55,weight: .regular)
        sendPhotoLabelTimer.textColor = .red
        self.view.addSubview(sendPhotoLabelTimer)
        
        
        
        let amountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        let amount = (self.commingRequestAccept.range/30)*50
        amountLabel .text = "Ücret: \(amount)"
        amountLabel .textAlignment = .center
        amountLabel .center.x = self.view.center.x
        amountLabel .center.y =  sendPhotoLabelTimer.center.y + 50
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
            sickInfoA.text = "Hastalık Hakkında bilgi"
            sickInfoA.textAlignment = .center
            sickInfoA.isUserInteractionEnabled = false
            sickInfoA.center.x = self.view.center.x
            sickInfoA.font = UIFont.systemFont(ofSize: 17)
            sickInfoA.center.y =  sickInfoTitle.center.y + 80
            self.view.addSubview(sickInfoA)

        }
        
        
        let finishButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
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
        print("Butona basıldı")
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
    }
    

}
