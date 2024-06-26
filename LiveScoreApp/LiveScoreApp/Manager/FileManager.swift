//
//  FileManager.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 01.06.24.
//

import Foundation
class FileManagerHelper {
    
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        let path = files[0].appendingPathExtension("users.json")
        print(path)
        return path
    }
    
    func savaUser(data: [User]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: getFilePath())
        } catch {
            //
        }
    }
    
    func getUser(complete: (([User]) -> Void)) {
        if let data =  try? Data(contentsOf: getFilePath()) {
            do {
                let user = try JSONDecoder().decode([User].self, from: data)
                complete(user)
            } catch {
                //
            }
        }
    }
    
    func deleteUser(index: Int) {
        getUser(complete: { users in
            var updatedUsers = users
            updatedUsers.remove(at: index)
            self.savaUser(data: updatedUsers)
        })
    }
    
    func changePswd(index: Int, pswd: String) {
        getUser(complete: { users in
            var updatedUsers = users
            updatedUsers[index].password = pswd
            self.savaUser(data: updatedUsers)
        })
    }
}
