//
//  RegisterController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 31.05.24.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pswdField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    let manager = FileManagerHelper()
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registration"
        nameField.layer.cornerRadius = 18
        nameField.layer.masksToBounds = true
        pswdField.layer.cornerRadius = 18
        pswdField.layer.masksToBounds = true
        emailField.layer.cornerRadius = 18
        emailField.layer.masksToBounds = true
        confirmField.layer.cornerRadius = 18
        confirmField.layer.masksToBounds = true
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Fullname",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        pswdField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailField.attributedPlaceholder = NSAttributedString(
            string: "E-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        confirmField.attributedPlaceholder = NSAttributedString(
            string: "Confirm password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        manager.getUser { userItems in
            self.users = userItems
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if let name = nameField.text,
        let email = emailField.text,
        let pswd = pswdField.text,
        let confirmPswd = confirmField.text {
            if !name.isEmpty && !email.isEmpty && !pswd.isEmpty && !confirmPswd.isEmpty {
                if pswd == confirmPswd {
                    let user = User(fullname: name, email: email, password: pswd)
                    users.append(user)
                    manager.savaUser(data: users)
                    navigationController?.popViewController(animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error",
                                                            message: "Passwords are not matched",
                                                            preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(ok)
                    present(alertController, animated: true)

                }
            } else {
                let alertController = UIAlertController(title: "Warning",
                                                        message: "Plese completely fill all fields",
                                                        preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(ok)
            }
        }
    }
    
}
