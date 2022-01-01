//
//  CommentMakeVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 27.12.2021.
//

import UIKit
import Firebase
class CommentMakeVC: UIViewController {

    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var scorePicker: UIPickerView!
    let score = ["1","2","3","4","5"]
    var scoreSelect:String?
    var getUserId:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        scorePicker.delegate = self
        scorePicker.dataSource = self
    }
    

    @IBAction func makeComment(_ sender: Any) {
        
        if commentText.text == "" {
            let alertController  = UIAlertController(title: "Uyarı", message: "Boş Kalan yeri doldurunuz", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            
            
            if let authUserName = Auth.auth().currentUser?.displayName {
                let commetData : [String:Any] = [
                    "comment" : commentText.text!,
                    "score" : Int(self.scoreSelect!)!,
                    "userName": authUserName
                
                ]
                if let getUserId = getUserId {  let uuid = UUID().uuidString
                    let db = Firestore.firestore()
                    db.collection("userList").document(getUserId).collection("commet").document(uuid).setData(commetData)
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
                
                
            }
            
      
          
            
        }
        
       
        
    }


}

extension CommentMakeVC : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.score[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Seçilen spor \(self.score[row])")
        self.scoreSelect =  self.score[row]
    }
    
   
    
    
}



