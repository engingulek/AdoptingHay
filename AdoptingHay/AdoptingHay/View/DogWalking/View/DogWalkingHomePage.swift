import UIKit
import Firebase
import UserNotifications
class DogWalkingHomePage: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var dogWalkingCollectionView: UICollectionView!
    var permissionCheck:Bool = true
    var dogWalkingtimer:Timer = Timer()
    var count:Int?
    var timerCounting:Bool = false
    var timerLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 100))
    var finishButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    var sendPhotoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    var sickInfoA = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    var sickInfo = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    var sickInfoTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
    var animalName = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    var amountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
    var  timerTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
    @IBOutlet weak var filterButtonOutlet: UIButton!
    var timer = Timer()
    private var dogWalkingListViewModel: DogWalkingListViewModel!
    private var sendRequestAccept : RequestAcceptViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        spinner.isHidden = false
        UNUserNotificationCenter.current().delegate = self
        self.count = 5
        
        dogWalkingCollectionView.delegate = self
        dogWalkingCollectionView.dataSource = self
        getAllAdvert()
        getAllSendRequest()
        filterButtonOutlet.isHidden = false
        dogWalkingCollectionView.reloadData()
        
   
        
        
        
              
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { granted, error in
            
            self.permissionCheck = granted
            
            if granted {
                print("İzin alma işlemi başarılı")
                
            }
            else {
                print("İzin alma işlemi başarısız")
                
            }
        }
        
//        getNotificationDogWalkingFromFirestore()
//        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
//            self.getNotificationDogWalkingFromFirestore()
//        })
        
        
        
        
        
        
        
 

       
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound])
    }
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)
        getAllAdvert()
        getAllSendRequest()
        dogWalkingCollectionView.reloadData()
    }
    
    
    func getNotificationDogWalkingFromFirestore(){
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        if let userId = userId {
            db.collection("userList").document("\(userId)").collection("dogWalkingNoti").getDocuments { snaphot, error in
                if error == nil {
                    if snaphot?.documents.count == UserDefaults.standard.integer(forKey: "notiCount"){
                        print("Yeni bildirim yok")
                    }
                    else {
                        UserDefaults.standard.set(snaphot?.documents.count, forKey: "notiCount")
                        if self.permissionCheck {
                            print("Yeni bir bildirim var")
                            for documents in (snaphot?.documents)! {
                                if let userName =  documents.get("sendUserName") {
                                    if let sendMessageBody = documents.get("notiMessage") {
                                        if let sendMessageSubtitle = documents.get("notiSubtitle") {
                                            print("\(sendMessageSubtitle)")
                                            let content =  UNMutableNotificationContent()
                                            content.title = "AdoptingHay"
                                            content.subtitle = "\(sendMessageSubtitle)"
                                            content.body = "\(sendMessageBody)"
                                            content.sound = UNNotificationSound.default
                                            // ilk çalıştıktan sonra kaç saniye sonra çalışacak onu belirtilir.
                                            let react = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                                            // Bildirim isteği oluşturulması
                                            let notii = UNNotificationRequest(identifier: "dogWalkingbildirim", content: content, trigger: react)
                                            // Bildirimin eklenmesi
                                            UNUserNotificationCenter.current().add(notii, withCompletionHandler: nil)
                                            
                                        }
                                      
                                        
                                    }
                                   
} }} }}} } }
    
    
    func getAllSendRequest()
    {
        DogWalkingService().getAcceptAdvert(collectionName: "sendAcceptAdvert") { request in
            if let request = request {
                self.sendRequestAccept = RequestAcceptViewModel(requestAccept: request)
                // süre self.sendRequestAccept.range*60
                self.count = 5
                let time = self.secondsToHoursMinutesSeconds(seconds: self.count!)
                let timeString = self.makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
                self.timerLabel.text = timeString
                
               if self.sendRequestAccept != nil {
                   
                   self.dogWalkingCollectionView.isHidden = true
                   self.dogWalkingCollectionView.reloadData()
                   self.acceptToRequestDesign()
                   self.filterButtonOutlet.isHidden = true
                    
                }
                
                else {
                    self.dogWalkingCollectionView.isHidden = false
                    self.dogWalkingCollectionView.reloadData()
                  
                    self.filterButtonOutlet.isHidden = false
                    
                }
            }
        }
    }
    
    
    
    func acceptToRequestDesign() {
      
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
        
        
       
        
        
    
        
        
        
        
        let amount = (self.sendRequestAccept.range/30)*50
        amountLabel .text = "Ücret: \(amount)"
        amountLabel .textAlignment = .center
        amountLabel .center.x = self.view.center.x
        amountLabel .center.y =  timerLabel.center.y + 50
        amountLabel .font = UIFont.systemFont(ofSize: 25, weight: .medium)
        amountLabel .textColor = .black
        self.view.addSubview(amountLabel)
        
    
        
      
        animalName.text = "Adı: \(self.sendRequestAccept.name) "
        animalName.textAlignment = .center
        animalName.center.x = self.view.center.x
        animalName.center.y = amountLabel.center.y + 50
        animalName.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        animalName.textColor = .black
        self.view.addSubview(animalName)
        
        
        sickInfoTitle.text = "Hastalık Bilgi"
        sickInfoTitle.textAlignment = .center
        sickInfoTitle.center.x = self.view.center.x
        sickInfoTitle.center.y =  animalName.center.y + 50
        sickInfoTitle.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        sickInfoTitle.textColor = .black
        self.view.addSubview(sickInfoTitle)
        
        if self.sendRequestAccept.sick == "Yok" {
            
            sickInfo.text = "Yok"
            sickInfo.textAlignment = .center
            sickInfo.center.x = self.view.center.x
            sickInfo.center.y =  sickInfoTitle.center.y + 50
            sickInfo.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            sickInfo.textColor = .black
            self.view.addSubview(sickInfo)
            
        }
        
        else {
           
            sickInfoA.backgroundColor = .systemGray5
            sickInfoA.text = "Hastalık Hakkında bilgi"
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
            
            print("Gezdirme İşlemi Bitti")
            if let authUserId = Auth.auth().currentUser?.uid as? String {
                if let uuid = self.sendRequestAccept.userId as? String {
                    
                    let updateData : [String:Any] = [
                        "acceptDogWalkingBool":"start"
                    ]
                    db.collection("userList").document(uuid).collection("acceptDogWalking").document(authUserId).getDocument { document, error in
                        
                        if let acceptBool = document?.get("acceptDogWalkingBool") as? String {
                            if acceptBool == "finish" {
                                
                                print("Gezdirme İşlemi bitirildi")
                                self.performSegue(withIdentifier: "toThanks", sender: nil)
                                if let advertId = self.sendRequestAccept.id as? String {
                                    db.collection("userList").document(authUserId).collection("sendAcceptAdvert").document(advertId).delete()
                                    self.dogWalkingCollectionView.isHidden = false
                                    self.dogWalkingCollectionView.reloadData()
                                  
                                    self.filterButtonOutlet.isHidden = false
                                    self.sickInfoTitle.isHidden = true
                                    self.animalName.isHidden = true
                                    self.amountLabel.isHidden = true
                                    self.timerTitleLabel.isHidden = true
                                    self.timerLabel.isHidden = true
                                    self.sendPhotoButton.isHidden = true
                                    self.sickInfo.isHidden = true
                                    self.sickInfoA.isHidden = true
                                    self.finishButton.isHidden = true
                                    
                                    
                                    
                                }
                                
                         
                                
                            }
                            
                            else {
                                print("İlan shibi gezdirme işlemini bitirmedi")
                                self.alertMessage(message: "İlan Sahibi Gezdirme İşlemnini Bitirmedi")
                            }
                        }
                        
                    }
                    
                    
                    
                    
                    
                   
                }
            }
        }
        else {
            
            if let authUserId = Auth.auth().currentUser?.uid as? String {
                if let uuid = self.sendRequestAccept.userId as? String {
                    
                    let updateData : [String:Any] = [
                        "acceptDogWalkingBool":"start"
                    ]
                    db.collection("userList").document(uuid).collection("acceptDogWalking").document(authUserId).getDocument { document, error in
                        
                        if let acceptBool = document?.get("acceptDogWalkingBool") as? String {
                            if acceptBool == "start" {
                                self.timerCounting = true
                                self.dogWalkingtimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
                                print("Gezdirme İşlemi başladı")
                                
                            }
                            
                            else {
                      
                                self.alertMessage(message: "İlan Sahibi Gezdirme İşlemini Başlatmadı")
                                
                               
                            }
                        }
                        
                    }
                    
                    
                    
                    
                    
                   
                }
            }
            
            
            
           
        }
    }
    
    func alertMessage(message:String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func sendPhotoButtonAction() {
        if let id = self.sendRequestAccept.userId as? String {
            if let userName = self.sendRequestAccept.userName as? String {
                let sendToGetMessageData : [String:Any] = [
                    "messageGetUserId" : id,
                    "messageGetUserName" : userName
                
                ]
                performSegue(withIdentifier: "mm", sender: sendToGetMessageData)
                
            }
        
            
        }
     
    }
    

    
 
    
    
    
    
    @IBAction func dogWalkingAdvertFilter(_ sender: Any) {
        // Create Action Controller
        let actionController = UIAlertController(title: "Sıralama ve Filtreleme", message: "Uygu işlemei seçinniz", preferredStyle: .actionSheet)
        
        
        let timeRangeShortMaxToMin = UIAlertAction(title: "Süre Azalan", style: UIAlertAction.Style.default) { actin in
            
            DogWalkingService().timeFilter(filterType: true) { dogwalkingAdvert in
                if let dogwalkingAdvert = dogwalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogwalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                    self.filterButtonOutlet.isHidden = false
                    
                    
                }
            }
            
        }
        
        let timeRangeMinToMax = UIAlertAction(title: "Süre Artan", style: .default) { action in
            DogWalkingService().timeFilter(filterType: false) { dogwalkingAdvert in
                if let dogwalkingAdvert = dogwalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogwalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                  
                   
                    
                    self.spinner.isHidden = true
                    
                    
                }
            }
            
        }
        
        let newDate = UIAlertAction(title: "En uzak tarih", style: .default) { action in
            DogWalkingService().dateFilter(filterType: true) { dogWalkingAdvert in
                
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
             
            }
            
        }
        
        
        let oldDate = UIAlertAction(title: "En yakın tarih", style: .default) { action in
            DogWalkingService().dateFilter(filterType: false) { dogWalkingAdvert in
                
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
             
            }
            
        }
        
        let sickFalse = UIAlertAction(title: "Hastalık Yok", style: .default) { action in
            DogWalkingService().sickFilter(sickBool: "Yok") { dogWalkingAdvert in
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
                
                
            }
            
        }
        
        let sickTrue = UIAlertAction(title: "Hastalık Var", style: .default) { action in
            DogWalkingService().sickFilter(sickBool: "Var") { dogWalkingAdvert in
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
                
            }
            
            
        }
        
        
        let all = UIAlertAction(title: "Bütün İlanlar", style: .destructive) { action in
            self.getAllAdvert()
        }
        
        let cancel = UIAlertAction(title: "İptal", style: .cancel) { action in
            print("İptal tıklandı")
        }
        
        actionController.addAction(timeRangeMinToMax)
        actionController.addAction(timeRangeShortMaxToMin)
        actionController.addAction(sickTrue)
        actionController.addAction(sickFalse)
        actionController.addAction(newDate)
        actionController.addAction(oldDate)
        actionController.addAction(all)
        actionController.addAction(cancel)
        
        
        self.present(actionController, animated: true, completion: nil)
        
        
        
    }
    
    
    // MARK : SERVICE CONNECT
    
    /// Get alll walking advert
    func getAllAdvert() {
        DogWalkingService().geDogWalkingAdvert { dogWalkingAdvert in
            if let walkingAdvert = dogWalkingAdvert {
                self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: walkingAdvert)
                self.dogWalkingCollectionView.reloadData()
                self.spinner.stopAnimating()
                
                self.spinner.isHidden = true
          
                
            }
        }
    }
    

 

}

extension DogWalkingHomePage : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dogWalkingListViewModel == nil {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
        return self.dogWalkingListViewModel == nil ? 0 : self.dogWalkingListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dogWalkingCollectionView.dequeueReusableCell(withReuseIdentifier: "dogWalkingAdvertsCell", for: indexPath) as! DogWalkingAdvertsCVC
        
        let advert = self.dogWalkingListViewModel.animalKindsAtIndex(indexPath.row)
        
        cell.advertsName.text = "Adı: \(advert.name)  "
        cell.advertsRange.text = "\(advert.range) dk"
        cell.ageGenusLabel.text = "Cins/Yaş : \(advert.kindsAndAge)"
        cell.advertsSick.text = "Hastalık: \(advert.sick)"
        cell.userName.text  = advert.userName
        cell.dateLabel.text = advert.addDate
        
    
      
        
        
        let imageUrl = URL(string:advert.image)!
        
        if let imageData = try?  Data(contentsOf: imageUrl) {
            cell.advertImageView.image = UIImage(data: imageData )
            
        }
        
        
      
        
        cell.layer.cornerRadius = 25
        
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = UIColor.blue.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let advert = self.dogWalkingListViewModel.animalKindsAtIndex(indexPath.row)
        if let authUserId = Auth.auth().currentUser?.uid {
            if authUserId == advert.userId {
                self.alertMessage(title: "Hata", messsage: "Kendi ilanınızdır")
            }
            else {
                performSegue(withIdentifier: "toDetailsWalking", sender: advert.dogWalkingAdvert )
                
            }
        }
        
    }
    
    
    // alert Message
    func alertMessage(title:String,messsage:String){
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController,animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsWalking" {
            
            if let getAdvert = sender as? DogwalkingAdvert {
                let toAdvertDetailVC = segue.destination as! DogWalkingAdvertDetailsVC
                toAdvertDetailVC.getAdvertWalking = getAdvert
                
            } }
        
        if segue.identifier == "mm" {
            if let data = sender as? [String:Any] {
            let toDogChatVC = segue.destination as! DogChatVC
                toDogChatVC.sendToGetMessageDataChat = data
            
        }
      
        }
    }
    
    
}
