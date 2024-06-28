//
//  FavoriteFileManager.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 26.06.24.
//

import Foundation

class FavoriteFileManagerHelper {
    
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("matches.json")
        print("File path: \(path)")
        return path
    }
    
    func saveMatch(data: [FavoriteMatches]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: getFilePath(), options: .atomicWrite)
            print("Matches saved successfully.")
        } catch {
            print("Failed to save matches: \(error.localizedDescription)")
        }
    }
    
    func getMatches(complete: @escaping ([FavoriteMatches]) -> Void) {
        let filePath = getFilePath()
        
        guard FileManager.default.fileExists(atPath: filePath.path) else {
            print("File does not exist.")
            complete([])
            return
        }
        
        do {
            let data = try Data(contentsOf: filePath)
            let matches = try JSONDecoder().decode([FavoriteMatches].self, from: data)
            complete(matches)
            print("Matches retrieved successfully.")
        } catch {
            print("Failed to retrieve matches: \(error.localizedDescription)")
            complete([])
        }
    }
    
    func deleteMatch(index: Int) {
        getMatches(complete: { matches in
            var updatedMatches = matches
            updatedMatches.remove(at: index)
            self.saveMatch(data: updatedMatches)
        })
    }
    
    func deleteAllMatches() {
        let filePath = getFilePath()
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
                print("All matches deleted successfully.")
            } catch {
                print("Failed to delete all matches: \(error.localizedDescription)")
            }
        } else {
            print("File does not exist, nothing to delete.")
        }
    }
}
