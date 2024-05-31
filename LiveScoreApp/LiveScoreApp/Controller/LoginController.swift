//
//  LoginController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 31.05.24.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var pswdField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        usernameField.layer.cornerRadius = 18
        usernameField.layer.masksToBounds = true
        pswdField.layer.cornerRadius = 18
        pswdField.layer.masksToBounds = true
        usernameField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        pswdField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "\(RegisterController.self)") as! RegisterController
        navigationController?.show(controller, sender: nil)
    }
    
}
