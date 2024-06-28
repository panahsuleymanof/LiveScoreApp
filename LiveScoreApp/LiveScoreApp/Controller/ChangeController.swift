//
//  ChangeController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 23.06.24.
//

import UIKit

class ChangeController: UIViewController {

    @IBOutlet weak var currentPswd: UITextField!
    @IBOutlet weak var newPswd: UITextField!
    @IBOutlet weak var confirmPswd: UITextField!
    
    var user = [LoggedUser]()
    var manager = FileManagerHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Password"
        currentPswd.layer.cornerRadius = 5
        currentPswd.layer.masksToBounds = true
        newPswd.layer.cornerRadius = 5
        newPswd.layer.masksToBounds = true
        confirmPswd.layer.cornerRadius = 5
        confirmPswd.layer.masksToBounds = true
        currentPswd.attributedPlaceholder = NSAttributedString(
            string: "Current password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        newPswd.attributedPlaceholder = NSAttributedString(
            string: "New Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        confirmPswd.attributedPlaceholder = NSAttributedString(
            string: "New password again",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        print(user)
        fetchUser()
    }
    
    func fetchUser() {
        do {
            user = try context.fetch(LoggedUser.fetchRequest())
            print(user)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updatePassword(password: String) {
        do {
            user[0].password = password
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func changeTapped(_ sender: Any) {
        if let nowPswd = currentPswd.text,
           let nextPswd = newPswd.text,
           let againPswd = confirmPswd.text{
            if nowPswd == user[0].password && !nextPswd.isEmpty && !againPswd.isEmpty{
                if nextPswd == againPswd {
                    manager.getUser(complete: { users in
                        print(users)
                        if let userIndex = users.firstIndex(where: {$0.email == user[0].email && $0.password == user[0].password}) {
                            if users[userIndex].password == nowPswd {
                                var updatedUsers = users
                                updatedUsers[userIndex].password = nextPswd
                                manager.savaUser(data: updatedUsers)
                                updatePassword(password: nextPswd)
                                navigationController?.popViewController(animated: true)
                            }
                        }
                    })
                }
            }
        }
    }
    
}
