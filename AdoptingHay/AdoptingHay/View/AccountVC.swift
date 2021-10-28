//
//  AccountVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 28.10.2021.
//

import UIKit

class AccountVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
               
                // view Design
        let myNewView=UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height/4.5))
            myNewView.backgroundColor=UIColor.red
        myNewView.layer.zPosition = -1
        self.view.addSubview(myNewView)
        
        // NameLabelDesign
        let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        myNameLabel.text = "Engin Gülek"
        myNameLabel.textAlignment = .center
        myNameLabel.center.x = self.view.center.x
        myNameLabel.center.y = self.view.center.y/4.5
        myNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        myNameLabel.textColor = .white
   
       

    
            
    self.view.addSubview(myNameLabel)
    
        
        

      
   
    
    }
    

 

}
