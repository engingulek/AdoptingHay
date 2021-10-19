//
//  ViewController.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appIcon: UIImageView!
  
    @IBOutlet weak var appTitleLabel: UILabel!
    
    @IBOutlet weak var mottoLabel: UILabel!
    
    @IBOutlet weak var goGoogleButton: UIButton!
    
    @IBOutlet weak var goEmailButton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        appTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        mottoLabel.font = UIFont.systemFont(ofSize: 27,weight: .bold)
        
        goGoogleButton.layer.cornerRadius = 15
        goEmailButton.layer.cornerRadius = 15
    
    }

    @IBAction func goEmailButtonActions(_ sender: Any) {
        print("Email ile devam et")
    }
    
    @IBAction func goGoogleButtonActions(_ sender: Any) {
        print("Google ile devam et")
    }
    
    
}

