//
//  SingUpEmailVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.10.2021.
//

import UIKit
import Firebase



class SingUpEmailVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldSurname: UITextField!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var secButtonOutlet: UIButton!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectUserImage))
        userImageView.addGestureRecognizer(gestureRecognizer)
        singUpButton.layer.cornerRadius = 15
        textFieldPassword.isSecureTextEntry = true
    }
    
    
   @objc func selectUserImage() {
       imagePicker.delegate = self
       imagePicker.sourceType = .photoLibrary
       self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userImageView.image = info[.originalImage] as? UIImage
        userImageView.layer.backgroundColor = UIColor.white.cgColor
        self.dismiss(animated: true, completion: nil)
        
        
        
    
    }
    
    
    
    
    @IBAction func secButtonAction(_ sender: Any) {
        if textFieldPassword.isSecureTextEntry == false {
            textFieldPassword.isSecureTextEntry = true
            if let image = UIImage(systemName: "eye.slash") {
                secButtonOutlet.setImage(image, for: .normal)
            }
            
        }
        else {
            textFieldPassword.isSecureTextEntry = false
            if let image = UIImage(systemName: "eye") {
                secButtonOutlet.setImage(image, for: .normal)
            }
        }
        
       
    }
    
    @IBAction func singUpButtonAction(_ sender: Any) {
        
        if textFieldName.text == "" || textFieldSurname.text == "" || textFieldEmail.text == "" || textFieldPassword.text == "" {
            self.alertMessage(title: "Hata", text: "Boş kalan yerleri lütfen doldurunuz")
        }
        
        else {
            
    
            
            
            
            
            
            
            
            
            Auth.auth().createUser(withEmail: textFieldEmail.text!,
                                   password: textFieldPassword.text!)
            { (authData, error) in
                if error != nil {
                    self.alertMessage(title: "Hata", text: error!.localizedDescription)
                }else
                {
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName =
                    "\(self.textFieldName.text!) \(self.textFieldSurname.text!)"
                    changeRequest?.commitChanges(completion: { error in
                        if error == nil {
                            self.addUserInfo()
                        
                        }
                    })
                    
                    


                  
                    


                    
                }}
//
            
            
        }
            
        }
    
    
    
    
    
    func addUserInfo() {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let profilImageFolder = storageReferance.child("profil")
        if let userId = Auth.auth().currentUser?.uid as? String {
            if let userName = Auth.auth().currentUser?.displayName as? String {
                if let imageData = self.userImageView.image?.jpegData(compressionQuality: 0.5){
                    
                    let imageDataUuid = UUID().uuidString
                    let imageReferance = profilImageFolder.child("\(imageDataUuid).jpeg")
                    imageReferance.putData(imageData,metadata: nil) {
                        metaData, error in
                        if error == nil {
                            imageReferance.downloadURL { url, error in
                                let imageUrl = url?.absoluteString
                                print("User image a \(imageUrl)")
                                let userInfo : [String:Any] = [
                                                       "userName": userName,
                                                       "userImage":imageUrl
                                                   ]
                                                   
                                                   db.collection("userInfo").document(userId).setData(userInfo)
                                
                            self.performSegue(withIdentifier: "singUptoHomePage", sender: nil)
                            }
                        }
                        }
                    
                    
                }
                
                
                
                
               
                
                   
                    
                
            }
       
            
        }
       
    }
    
    
    
   
        
      
    
    func alertMessage(title:String,text:String){
        let alertMessage = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Okey", style: .cancel)
        alertMessage.addAction(alertButton)
        self.present(alertMessage, animated: true)
    }
    
}
