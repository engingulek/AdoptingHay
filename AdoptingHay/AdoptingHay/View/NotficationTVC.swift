//
//  NotficationTVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.10.2021.
//

import UIKit

class NotficationTVC: UITableViewCell {

    
    @IBOutlet weak var notficationImageView: UIImageView!
    
    @IBOutlet weak var notficationNameLabel: UILabel!
    @IBOutlet weak var notficationNotfiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func notficationtoProfilButton(_ sender: Any) {
        print("Profile git tıklandı")
    }
    
    
  
    
}
