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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let loggedUser = [LoggedUser]()
    let userDefaults = UserDefaults.standard
    let manager = FileManagerHelper()
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        usernameField.layer.cornerRadius = 18
        usernameField.layer.masksToBounds = true
        pswdField.layer.cornerRadius = 18
        pswdField.layer.masksToBounds = true
        usernameField.attributedPlaceholder = NSAttributedString(
            string: "E-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        pswdField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func saveItem(userName: String, userEmail: String, userPswd: String) {
        do {
            let model = LoggedUser(context: context)
            model.name = userName
            model.email = userEmail
            model.password = userPswd
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "\(RegisterController.self)") as! RegisterController
        navigationController?.show(controller, sender: nil)
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        if let name = usernameField.text,
           let pswd = pswdField.text {
            if !name.isEmpty && !pswd.isEmpty {
                manager.getUser { user in
                    self.users = user
                }
                
                if let userIndex = users.firstIndex(where: {$0.email == name && $0.password == pswd}) {
                    userDefaults.set(true, forKey: "isLoggedIn")
                    let scene = UIApplication.shared.connectedScenes.first
                    saveItem(userName: users[userIndex].fullname, userEmail: name, userPswd: pswd)
                    if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
                        sceneDelegate.setHomeAsRoot()
                    }
                } else {
                    let alertController = UIAlertController(title: "Warning!", message: "Email or password is incorrect", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(ok)
                    present(alertController, animated: true)
                }
            } else {
                let alertController = UIAlertController(title: "Warning!", message: "Please enter full information", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(ok)
                present(alertController, animated: true)
            }
        }
    }
}
