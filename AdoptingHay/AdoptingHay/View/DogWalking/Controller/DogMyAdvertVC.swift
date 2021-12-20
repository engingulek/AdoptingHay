//
//  DogMyAdvertVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 20.12.2021.
//

import UIKit

class DogMyAdvertVC: UIViewController {
    
    @IBOutlet weak var advertCount: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var myDogAdvertTableView: UITableView!
    
    
    var myAdvertListViewModel : DogMyAdvertListViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        design()
        spinner.startAnimating()
        spinner.isHidden = false
        myDogAdvertTableView.delegate = self
        myDogAdvertTableView.dataSource = self
        
        getAllMyAdvert()
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        getAllMyAdvert()
        
        myDogAdvertTableView.reloadData()
        
        let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        if self.myAdvertListViewModel == nil {
            self.myDogAdvertTableView.isHidden = true
            self.advertCount.text = "0 İlan"
            myNameLabel.text = "İlan Listeniz Boş"
            myNameLabel.textAlignment = .center
            myNameLabel.center.x = self.view.center.x
            myNameLabel.center.y = self.view.center.y
            myNameLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            myNameLabel.textColor = .black
            self.view.addSubview(myNameLabel)
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
        
        else {
            self.myDogAdvertTableView.isHidden  = false
            let counst = self.myAdvertListViewModel == nil ? 0 :  self.myAdvertListViewModel.numberOfRowsInSection()
            myNameLabel.isHidden = true
            self.advertCount.text = "\(counst) İlan"
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            
            
        }
        
        
        
    }
    
    func getAllMyAdvert() {
        DogWalkingService().dowlondDogMyAdvert { myAdvert in
            if let myAdvert = myAdvert {
                
                self.myAdvertListViewModel = DogMyAdvertListViewModel(dogMyAdvertListViewModel: myAdvert)
                self.myDogAdvertTableView.reloadData()
                
            }
        }
        
    }
    
    
    
    
    
    // My Advert Page Header Design
    func design() {
        let myNewView=UIView(frame: CGRect(x: 0, y: 95, width: view.frame.size.width, height: view.frame.height/6))
        myNewView.backgroundColor=UIColor.red
        myNewView.layer.zPosition = -1
        myNewView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        self.view.addSubview(myNewView)
        
        
        let  titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        titleLabel.text = "İlanlarım"
        titleLabel.textAlignment = .center
        titleLabel.center.x = self.view.center.x
        titleLabel.center.y = myNewView.center.y
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .white
        self.view.addSubview(titleLabel)
        
    }
    
}




extension DogMyAdvertVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myAdvertListViewModel == nil ? 0 : self.myAdvertListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myDogAdvertTableView.dequeueReusableCell(withIdentifier: "myAdvertCell", for: indexPath) as! DogMyAdvertCell
        let myAdvert = self.myAdvertListViewModel.animalKindsAtIndex(indexPath.row)
        
        cell.nameLabel.text = "Adı: \(myAdvert.name)"
        cell.rangeLabel.text = "\(myAdvert.range) dk" 
        cell.genusAge.text = "Cins/Yaş \(myAdvert.genusAndAge)"
        cell.sickBool.text = "Hastalık \(myAdvert.sick)"
        
        let imageUrl = URL(string:myAdvert.image)!
        
        if let imageData = try?  Data(contentsOf: imageUrl) {
            cell.animalImageView.image = UIImage(data: imageData)
            
        }
        
        cell.layer.cornerRadius = 25
        
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = UIColor.red.cgColor
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myAdvert = self.myAdvertListViewModel.animalKindsAtIndex(indexPath.row)
        performSegue(withIdentifier:"toMyAdvertDetail", sender: myAdvert.dogmyAdvert )
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMyAdvertDetail" {
            
            if let getMyAdvert = sender as? DogMyAdvert{
                let toDogMyvDetailVC = segue.destination as! DogMyAdvertDetail
                toDogMyvDetailVC.getAdvert = getMyAdvert
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Kaldır") { contextuaActcion, viewa, boolValue in
            if let advertUid = self.myAdvertListViewModel.animalKindsAtIndex(indexPath.row).advertId as? String{
                
                
                
                
                DogWalkingService().removeMyAdvert(advertId: advertUid)
                self.myAdvertListViewModel.dogMyAdvertListViewModel.remove(at: indexPath.row)
                self.myDogAdvertTableView.deleteRows(at: [indexPath], with: .fade)
                
                
                
                
            }
            
            
            
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    
    
    
    
    
}
