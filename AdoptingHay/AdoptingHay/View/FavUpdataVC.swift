//
//  FavUpdataVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 6.12.2021.
//

import UIKit
import Firebase
class FavUpdataVC: UIViewController {
    private var favoritListViewModel : FavoritListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriList()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        getFavoriList()
       
        
        
       if self.favoritListViewModel == nil {
          
            performSegue(withIdentifier: "listFalse", sender:nil )
            
        }
        
        else {
            performSegue(withIdentifier: "listTrue", sender: nil)
        }
        
       
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
                     
                        
                        
                        
                        
                      
                        
                    }
                   
                }
            }
        }
    }

    

  

}
