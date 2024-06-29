//
//  ProfileController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 22.06.24.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var userFullname: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    var user = [LoggedUser]()
    var manager = FileManagerHelper()
    var matchManager = FavoriteFileManagerHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUser()
    }
    
    func fetchUser() {
        do {
            user = try context.fetch(LoggedUser.fetchRequest())
            userFullname.text = user[0].name
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteItem(index: Int) {
        do {
            context.delete(user[index])
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func changeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "\(ChangeController.self)") as! ChangeController
        navigationController?.show(vc, sender: nil)
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            self.deleteItem(index: 0)
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
                sceneDelegate.setLoginAsRoot()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    @IBAction func deleteAccountTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account? This action cannot be undone.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.manager.getUser { users in
                if let userIndex = users.firstIndex(where: { $0.email == self.user[0].email && $0.password == self.user[0].password }) {
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    self.deleteItem(index: 0)
                    self.manager.deleteUser(index: userIndex)
                    self.matchManager.deleteAllMatches()
                    let scene = UIApplication.shared.connectedScenes.first
                    if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
                        sceneDelegate.setLoginAsRoot()
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
