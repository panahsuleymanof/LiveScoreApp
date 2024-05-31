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
    }
    

}
