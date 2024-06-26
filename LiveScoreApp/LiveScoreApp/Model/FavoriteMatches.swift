//
//  FavoriteMatches.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 25.06.24.
//

import Foundation

struct FavoriteMatches: Codable {
    let countryName: String
    let leagueName: String
    let homeName: String
    let awayName: String
    let homeScore: String
    let awayScore: String
    var isfavorited: Bool
}
