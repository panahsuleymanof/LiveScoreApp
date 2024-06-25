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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        deleteItem(index: 0)
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
            sceneDelegate.setLoginAsRoot()
        }
    }
    
    @IBAction func deleteAccountTapped(_ sender: Any) {
        deleteItem(index: 0)
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
            sceneDelegate.setLoginAsRoot()
        }
    }
}
