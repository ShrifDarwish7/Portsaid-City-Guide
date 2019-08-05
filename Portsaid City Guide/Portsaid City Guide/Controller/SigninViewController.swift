//
//  ViewController.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/20/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import TextFieldEffects
import FacebookCore
import FacebookLogin
import Firebase
import SwiftyJSON

class SigninViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    var username = HoshiTextField()
    var password = HoshiTextField()
    var photoURL : String = " "

    
    override func viewDidLoad() {
        super.viewDidLoad()
        username = HoshiTextField(frame: CGRect.init(x: 0, y: 0, width: loginContainerView.frame.width, height: 55))
        password = HoshiTextField(frame: CGRect.init(x: 0, y: 55, width: loginContainerView.frame.width, height: 55))
        password.isSecureTextEntry = true

        
        username.delegate = self
        password.delegate = self
        
        username.setUpTextField(placeholder: "Username")
        password.setUpTextField(placeholder: "Password")
        
        loginContainerView.addSubview(username)
        loginContainerView.addSubview(password)
        
        signinBtn.setupBtn(label: "SignIn")
        registerBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.6208128333, blue: 0.002599901985, alpha: 1)
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.cornerRadius = 5

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.resignFirstResponder()
        password.resignFirstResponder()
        
        return true
    }
    @IBAction func signinClicked(_ sender: UIButton) {
    }
    
    @IBAction func cretNewAccClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegVC", sender: self)
    }
    @IBAction func FBLogin(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.loginBehavior = .browser
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile,ReadPermission.email,ReadPermission.userPhotos], viewController: self) { (result) in
            switch result {
            case .cancelled :
                print("Cancel")
            case .failed(let error):
                print(error.localizedDescription)
            case .success(grantedPermissions: _, declinedPermissions: _, token: let accessToken):
                print("Loggin success")
                self.getProfilePicture(accessToken: accessToken)
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (result, error) in
                    if error == nil {
                        
                        let ref = Database.database().reference().child("Users")
                        let userData : [String : String] = ["Username" : (result?.user.displayName!)! ,
                                                            "Email" : (result?.user.email!)!,
                                                            "ProfilePicture" : self.photoURL]
                        ref.child(accessToken.userId!).setValue(userData)
                        print("successful write to firebase db")
                    }else{
                        print("failed writing to firebase \(String(describing: error?.localizedDescription))")
                    }
                })

            }
        }

    }
    func getProfilePicture(accessToken : AccessToken){
        var model : JSON?
        let connection = GraphRequestConnection()
        connection.add(GraphRequest.init(graphPath: "/me/picture", parameters: ["height" : 150 , "width" : 150 , "redirect" : false], accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)){ (response, result) in
            switch result {
            case .success(let response):
                model = JSON.init(response.dictionaryValue!)
                self.photoURL = model!["data"]["url"].stringValue
                print("photo url ---> \(self.photoURL )")
            case .failed(let error):
                    print("error \(error.localizedDescription)")
            }
        }
        connection.start()
    }

}







