//
//  MyAdvertVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.12.2021.
//

import UIKit
import Firebase
class MyAdvertVC: UIViewController {
   
    
    
    @IBOutlet weak var myAdvertsCount: UILabel!
    private var myAnimalAdvertListViewModel : MyAnimalAdvertListViewModel!
    var resultCount : Int?
    
 
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var myAdvertsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        myAdvertsCollectionView.delegate = self
        myAdvertsCollectionView.dataSource = self
        getMyAnimalAdvert()
        spinner.startAnimating()
        
        self.tabBarController?.tabBar.isHidden = true
        myAdvertsCollectionView.reloadData()
        
        design()
       
    
    }
    
    func design(){
       
    
        let myNewView=UIView(frame: CGRect(x: 0, y: 95, width: view.frame.size.width, height: view.frame.height/6))
            myNewView.backgroundColor=UIColor.red
        myNewView.layer.zPosition = -1
        myNewView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        self.view.addSubview(myNewView)
        
        let personImage = UIImage(named: "heart")
        let myImageView:UIImageView = UIImageView()
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = self.view.frame.width/4
        myImageView.frame.size.height = self.view.frame.height/8
        myImageView.center.x = self.view.center.x
        myImageView.center.y = self.view.center.y/2.5
        myImageView.image = personImage
        myImageView.backgroundColor = .white
        myImageView.layer.borderColor = UIColor.red.cgColor
        myImageView.layer.borderWidth = 3
        myImageView.layer.cornerRadius = 15
        myImageView.backgroundColor = UIColor.red
        self.view.addSubview(myImageView)
        
      

      
    }
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        getMyAnimalAdvert()
        if self.myAnimalAdvertListViewModel == nil {
            self.myAdvertsCollectionView.isHidden = true
            self.myAdvertsCount.text = "0 İlan"
            
            let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
            myNameLabel.text = "İlanınz Bulunmamaktadır"
            myNameLabel.textAlignment = .center
            myNameLabel.center.x = self.view.center.x
            myNameLabel.center.y = self.view.center.y
            myNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            myNameLabel.textColor = .black
            self.view.addSubview(myNameLabel)
        }
        
        else {
            
            self.myAdvertsCollectionView.isHidden = false
            let counts = self.myAnimalAdvertListViewModel == nil ? 0 :
            self.myAnimalAdvertListViewModel.numberOfRowsInSection()
            self.myAdvertsCount.text = "\(counts) İlan"
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
                        
                   
                 
                     
                        
              
                     
                        
                     
                        self.myAdvertsCollectionView.reloadData()
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        
                    }
                   
                }
            }
            
        }
        
       
        
       
        
    }
    

    

    


}

extension MyAdvertVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myAnimalAdvertListViewModel == nil ? 0 : self.myAnimalAdvertListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  myAdvertsCollectionView.dequeueReusableCell(withReuseIdentifier: "myadvertsCell", for: indexPath) as! MyAdvertsCVC
        
        
        let myAdvert = self.myAnimalAdvertListViewModel.animalAdvertAtIndex(indexPath.row)
        
        
        
        cell.advertName.text = "Adı : \(myAdvert.name)"
        cell.advertAge.text = "Yaş : \(myAdvert.age)"
        cell.advertGenus.text = "Cins : \(myAdvert.kinds)/\(myAdvert.genus)"
        cell.advertSick.text = "Hastalık : \(myAdvert.sick)"
        let imageUrl = URL(string: myAdvert.image)!
        if let imageData = try? Data(contentsOf: imageUrl)
        {
            cell.advertImageView.image = UIImage(data: imageData)
        }
        
        
        cell.layer.cornerRadius = 25
  
         cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.red.cgColor
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let myAdvert = self.myAnimalAdvertListViewModel.animalAdvertAtIndex(indexPath.row)
        performSegue(withIdentifier: "myAdverttoDetails", sender: myAdvert.myAdvert)
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myAdverttoDetails" {
            
            if let getAnimalAdvert = sender as? MyAdvert {
                let toMyAdvertDetailVC = segue.destination as! MyAdvertDetailsVC
                toMyAdvertDetailVC.getAdvert = getAnimalAdvert
            }
            
        }
    }
    
}
