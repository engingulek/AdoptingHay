//
//  AccountVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 28.10.2021.
//

import UIKit
import Firebase
import Kingfisher

class AccountVC: UIViewController{
 
  
    @IBOutlet weak var favoriteListButtonOutlet: UIButton!
    
    @IBOutlet weak var myAdvertListButtonOutlet: UIButton!
    let myImageView:UIImageView = UIImageView()
    private var favoritListViewModel : FavoritListViewModel!
    private var myAnimalAdvertListViewModel: MyAnimalAdvertListViewModel!
    var resultFavoriListCount:Int?
    var resultMyAdvertCount:Int?
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriList()
        getMyAnimalAdvert()
        
        
        accountOwner()
      

       
        favoriteListButtonOutlet.layer.cornerRadius = 10
        myAdvertListButtonOutlet.layer.cornerRadius = 10
        
     
       /*
        print(Auth.auth().currentUser?.email)
       */
        
       
      
    
       
        
        
    
        design()
        

      
   
    
    }
    override func viewDidAppear(_ animated: Bool) {
        getFavoriList()
        getMyAnimalAdvert()
        accountOwner()
    }
    


    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        getFavoriList()
        getMyAnimalAdvert()
        accountOwner()
        
     
    }
    
    func getFavoriList() {
        let userId =  Auth.auth().currentUser?.uid
      
        if let userId = userId {
            Service().dowloadFavoriteListAdvert(uuid: userId) { myAnimal in
                if myAnimal == nil {
                    print("My advert list hata" )
                }
                
                else {
                    if let myAnimal = myAnimal {
                        self.favoritListViewModel = FavoritListViewModel(favoritList: myAnimal)
                        let counst = self.favoritListViewModel == nil ? 0 :  self.favoritListViewModel.numberOfRowsInSection()
                        print("gaga \(counst)")
                     
                        self.resultFavoriListCount = counst
                     
                      
                        
                    }
                   
                }
            }
        }
    }
    
    
    
    func getMyAnimalAdvert() {
        let userId =  Auth.auth().currentUser?.uid
        if let userId = userId {
            Service().dowloadMyAnimalAdvert(uuid: userId) { myAnimal in
                if myAnimal == nil {
                    print("My advert list hata" )
                }
                
                else {
                    if let myAnimal = myAnimal {
                        self.myAnimalAdvertListViewModel = MyAnimalAdvertListViewModel(myAdvertList: myAnimal)
                        
                        let counst = self.myAnimalAdvertListViewModel == nil ? 0 : self.myAnimalAdvertListViewModel.numberOfRowsInSection()
                        self.resultMyAdvertCount = counst
                 
                     
                        
                      
                     
                        
                     
                      
                        
                    }
                   
                }
            }
            
        }
        
       
        
       
        
    }
    
    
    @IBAction func toFavoriListButton(_ sender: Any) {
      

          
                self.performSegue(withIdentifier: "toDetailsFav", sender: nil)
                

    }
    
    
    
    @IBAction func toMyAdvertList(_ sender: Any) {
            performSegue(withIdentifier: "toMyAdvert", sender: nil)
    }
    
   
  
    
    func design() {
        // view Design
let myNewView=UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height/4.5))
    myNewView.backgroundColor=UIColor.red
       
myNewView.layer.zPosition = -1
self.view.addSubview(myNewView)
        

// NameLabelDesign
let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        myNameLabel.text = Auth.auth().currentUser?.displayName
myNameLabel.textAlignment = .center
myNameLabel.center.x = self.view.center.x
myNameLabel.center.y = self.view.center.y/4.5
myNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
myNameLabel.textColor = .white
self.view.addSubview(myNameLabel)

//AccountImage

                    myImageView.contentMode = UIView.ContentMode.scaleAspectFit
                    myImageView.frame.size.width = self.view.frame.width/4
                    myImageView.frame.size.height = self.view.frame.height/8
                    myImageView.center.x = self.view.center.x
                    myImageView.center.y = self.view.center.y/2.5
                    
                    myImageView.backgroundColor = .white
                    myImageView.layer.borderColor = UIColor.red.cgColor
                    myImageView.layer.borderWidth = 3
                    myImageView.layer.cornerRadius = 15
                    view.addSubview(myImageView)
                    
                
                
            
        
        
        
        
 
        
        
        
        
     
        
    
        
        

        
    }
    
    
    func accountOwner() {
        let db = Firestore.firestore()
        if let getUserId = Auth.auth().currentUser?.uid {
            db.collection("userInfo").document(getUserId).getDocument { snapshot, error in
                if let userName = snapshot?.get("userName") as? String {
                    if let userImage = snapshot?.get("userImage") as? String {
                        
                       
                        self.myImageView.kf.setImage(with: URL(string: userImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
//                        myImage.kf.setImage(with: URL(string:sendImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
                    }
                    
                    
                }
            }
        }
       
    }

 
    @IBAction func exitAccountButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
     do {
       try firebaseAuth.signOut()
         performSegue(withIdentifier: "exitToSingPage", sender: nil)
     } catch let signOutError as NSError {
       print("Error signing out: %@", signOutError)
     }
        
    }
    
    
    
    
    
}





