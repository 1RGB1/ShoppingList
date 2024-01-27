//
//  Global.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 27/01/2024.
//

import Foundation
    
class Global {
    static var items: [ItemModel] = [
        ItemModel(
            id: 56372,
            name: "Orange",
            quantity: 10,
            description: "Orange, any of several species of small trees or shrubs of the genus Citrus of the family Rutaceae and their nearly round fruits, which have leathery and oily rinds and edible, juicy inner flesh",
            isBought: false
        ),
        ItemModel(
            id: 5438281,
            name: "Apple",
            quantity: 5,
            description: "Green apples are medium in size (approximately 2 ¼ inches across) and round-conical in shape, with some ribbing. The Green apple's white flesh is hard, crispy, and juicy. The flavor of Green apples is extremely acidic, sometimes to the point of not having other taste, but generally refreshing.",
            isBought: false
        ),
        ItemModel(
            id: 627194,
            name: "Carrot",
            quantity: 3,
            description: "Carrot is a biennial, belonging to the family Apiaceae, and is an important vegetable for its fleshy edible, colorful roots. It varies in colour from white, yellow, orange, light purple, deep red to deep violet.",
            isBought: true
        )
    ]
}
