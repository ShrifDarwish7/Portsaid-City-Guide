//
//  RegisterViewController.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/21/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var userInfoContainer: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var profilePicImgView: UIImageView!
    
    var username = HoshiTextField()
    var password = HoshiTextField()
    var email = HoshiTextField()
    
    var downloadURL : String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username = HoshiTextField.init(frame: CGRect.init(x: 0, y: 0, width: userInfoContainer.frame.width, height: 50))
        password = HoshiTextField.init(frame: CGRect.init(x: 0, y: 50, width: userInfoContainer.frame.width, height: 50))
        email = HoshiTextField.init(frame: CGRect.init(x: 0, y: 100, width: userInfoContainer.frame.width, height: 50))
        
        username.setUpTextField(placeholder: "Username")
        password.setUpTextField(placeholder: "Password")
        email.setUpTextField(placeholder: "Email")
        
        userInfoContainer.addSubview(username)
        userInfoContainer.addSubview(password)
        userInfoContainer.addSubview(email)
        
        password.isSecureTextEntry = true
        
        username.delegate = self
        password.delegate = self
        email.delegate = self
        
        registerBtn.setupBtn(label: "Register")
        cancelBtn.setupBtn(label: "Cancel")
        
        circularImg(image: profilePicImgView)
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.handleProfilePicGesture))
        profilePicImgView.addGestureRecognizer(gesture)
        
    }
    @objc func handleProfilePicGesture(){
        
        let imgPicker = UIImagePickerController.init()
        imgPicker.allowsEditing = true
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        present(imgPicker, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            profilePicImgView.image = image
        }else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicImgView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.resignFirstResponder()
        password.resignFirstResponder()
        email.resignFirstResponder()
        
        return true
    }
    @IBAction func regBtnClicked(_ sender: UIButton) {
        SVProgressHUD.show()
        createUser()
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createUser(){
        if username.text! == "" || password.text! == "" || email.text! == "" {
            popUpAlert(message: "You must fill all fields ...")
            SVProgressHUD.dismiss()
        }else{
            self.uploadProfilePicture(Image: self.profilePicImgView.image!, email: email.text!)
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error != nil {
                    self.popUpAlert(message: (error?.localizedDescription)!)
                    SVProgressHUD.dismiss()
                }else{
                    let ref = Database.database().reference().child("Users")
                    let userData : [String : String] = ["Username" : self.username.text ?? "Nil" ,
                                                     "Email" : user?.user.email! ?? "Nil",
                                                     "ProfilePicture" : self.downloadURL]
                    ref.child((user?.user.uid)!).setValue(userData)
                    SVProgressHUD.dismiss()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    func uploadProfilePicture(Image : UIImage,email : String){
        let image = UIImageJPEGRepresentation(Image, 1.0)
        let storageRef = Storage.storage().reference().child("Users").child(email)
        let uploadTask = storageRef.putData(image!, metadata: nil) { (meta, error) in
            if error == nil {
                print("----->> success to upload image")
                storageRef.downloadURL(completion: { (url, error) in
                    if error == nil{
                        self.downloadURL = (url?.absoluteString)!
                        print("photo url --- > \(self.downloadURL)")
                    }else{
                        print("error download URL --> \(error?.localizedDescription ?? "Failed to download URL")")
                    }
                })
            }else{
                self.popUpAlert(message: (error?.localizedDescription)!)
            }
            
        }
        uploadTask.resume()
        /*uploadTask.observe(.success) { (snapshot) in
         storageRef.downloadURL(completion: { (url, error) in
         /*guard downloadUrl == url else{
         self.errorPopUpAlert(errorMessage: (error?.localizedDescription)!)
         return
         }*/
         self.downloadURL = (url?.absoluteString)!
         })
         }*/
    }
    
}












