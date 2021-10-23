//
//  SingInwithEmailVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit




class SingInwithEmailVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var singInContainer: UIView!
    
    @IBOutlet weak var singUpContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont.systemFont(ofSize: 16)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
       
       
       
    }

    
 
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("Giriş Yap")
            singInContainer.isHidden = true
            singUpContainer.isHidden = false
            
            break
            
        case 1:
            print("Üye Ol")
            singInContainer.isHidden = false
            singUpContainer.isHidden = true
            break
        
        
        default:
            break
        }
    }
    
  

}
