//
//  FavoriteFileManager.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 26.06.24.
//

import Foundation

class FavoriteFileManagerHelper {
    
    // Get the file path for the JSON file
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("matches.json") // Corrected
        print("File path: \(path)")
        return path
    }
    
    // Save favorite matches to a JSON file
    func saveMatch(data: [FavoriteMatches]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: getFilePath(), options: .atomicWrite)
            print("Matches saved successfully.")
        } catch {
            print("Failed to save matches: \(error.localizedDescription)")
        }
    }
    
    // Retrieve favorite matches from the JSON file
    func getMatches(complete: @escaping ([FavoriteMatches]) -> Void) {
        let filePath = getFilePath()
        
        // Check if file exists
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
    
    // Delete a match from the JSON file by index
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
