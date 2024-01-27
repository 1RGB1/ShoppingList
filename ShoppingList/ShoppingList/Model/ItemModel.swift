//
//  ItemModel.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation

struct ItemModel: Codable {
    var id: Int
    var name: String?
    var quantity: Int?
    var description: String?
    var isBought: Bool?
}
