//
//  HoleData.swift
//  Mancala
//
//  Created by Abby on 2023/4/4.
//

import Foundation
import SwiftUI
struct ItemsData:Identifiable{
    var id = UUID()
    var item:String
    var offset = CGSize.zero
    var rotation = Angle.degrees(0)
    init(id: UUID = UUID(), item: String) {
        self.id = id
        self.item = item
        offset = CGSize(width: CGFloat.random(in: 0...30), height: CGFloat.random(in: 0...30))
        rotation = Angle(degrees: Double.random(in: 0...720))
    }
}
struct HoleData:Identifiable{
    //var color:Color
    var id = UUID()
    var position:Int
    var amount:Int
    var items:[ItemsData]
    
    init(id: UUID = UUID(), position: Int, amount: Int) {
        self.id = id
        self.position = position
        self.amount = amount
        let dices = ["peral1","peral2","peral3","peral4","peral5","peral6","peral7","peral8"]
        items = [ItemsData]()
        while items.count != amount{
            let dice = dices.randomElement()!
            items.append(ItemsData(item: dice))
        }
    }
}
