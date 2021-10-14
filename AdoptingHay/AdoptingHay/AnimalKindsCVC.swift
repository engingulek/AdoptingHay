//
//  AnimalKindsCVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class AnimalKindsCVC: UICollectionViewCell {
    
    static let identifier = "AnimalKindsCollectionViewCell"
    
    private let animalKindsImage: UIImageView = {
       let animalKindsImageView = UIImageView()
        animalKindsImageView.clipsToBounds = true
        animalKindsImageView.contentMode = .scaleAspectFill
        animalKindsImageView.layer.masksToBounds = true
        //animalKindsImageView.layer.cornerRadius = 150.0 / 2.0
       // animalKindsImageView.backgroundColor = .blue
        //animalKindsImageView.layer.borderWidth = 2
        //animalKindsImageView.layer.borderColor = UIColor.link.cgColor
    
        
        
        return animalKindsImageView
    }()
    override init (frame:CGRect) {
        super.init(frame: frame)
       
        contentView.addSubview(animalKindsImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animalKindsImage.frame =  contentView.bounds
    }
    
    
    public func configure(with name: String) {
        animalKindsImage.image = UIImage(named: name)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animalKindsImage.image = nil
    }
    
}
