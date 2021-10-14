//
//  HomePageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    private var animalKindsCollectionView : UICollectionView?

    private let animalKinds = ["cat","bird","hamster"]
    override func viewDidLoad() {
        super.viewDidLoad()

        accountButton.layer.cornerRadius = 10
        searchBar.delegate = self
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 72, height: 72)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
    
        
        
        
        animalKindsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        animalKindsCollectionView?.register(AnimalKindsCVC.self, forCellWithReuseIdentifier: AnimalKindsCVC.identifier)
        animalKindsCollectionView?.showsHorizontalScrollIndicator = false
        animalKindsCollectionView?.delegate = self
        animalKindsCollectionView?.dataSource = self
        animalKindsCollectionView?.backgroundColor = .white
        
        guard let myCollectionView = animalKindsCollectionView else {
            return
        }
        
        view.addSubview(myCollectionView)
        
        
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animalKindsCollectionView?.frame = CGRect(x: 0, y: 140, width: view.frame.size.width, height: 150).integral
    }
    

  

}

extension HomePageVC:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


extension HomePageVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalKinds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = animalKindsCollectionView?.dequeueReusableCell(withReuseIdentifier: AnimalKindsCVC.identifier, for: indexPath) as! AnimalKindsCVC
        cell.configure(with: animalKinds[indexPath.row])
        cell.frame.size.width = 50
        cell.frame.size.height = 50
        cell.backgroundColor = .white
        
        return cell
    }
    
    
}



