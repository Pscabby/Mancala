//
//  ScoreData.swift
//  Mancala
//
//  Created by Abby on 2023/4/8.
//

import Foundation

struct ScoreData :Codable,Identifiable{
    let id = UUID()
    var total : Int
    var win : Int
    var lose : Int
    var draws : Int
}
