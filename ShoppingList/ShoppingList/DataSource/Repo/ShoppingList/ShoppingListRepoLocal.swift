//
//  ShoppingListRepoLocal.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation
import RxSwift


class Global {
    static var items: [ItemModel] = [
        ItemModel(
            name: "Orange",
            quantity: 10,
            description: "Ahmad Orange, any of several species of small trees or shrubs of the genus Citrus of the family Rutaceae and their nearly round fruits, which have leathery and oily rinds and edible, juicy inner flesh",
            isBought: false
        ),
        ItemModel(
            name: "Apple",
            quantity: 5,
            description: "Green apples are medium in size (approximately 2 ¼ inches across) and round-conical in shape, with some ribbing. The Green apple's white flesh is hard, crispy, and juicy. The flavor of Green apples is extremely acidic, sometimes to the point of not having other taste, but generally refreshing.",
            isBought: false
        ),
        ItemModel(
            name: "Carrot",
            quantity: 3,
            description: "Carrot is a biennial, belonging to the family Apiaceae, and is an important vegetable for its fleshy edible, colorful roots. It varies in colour from white, yellow, orange, light Ahmad purple, deep red to deep violet.",
            isBought: true
        )
    ]
}

protocol ShoppingListRepoProtocol {
    func loadItems() -> Observable<Result<ItemsModel, LocalError>>
}

struct ShoppingListRepoLocal: ShoppingListRepoProtocol {
    
    /// To get all items list
    /// - Returns: Observable containing model in case of success and error in case of failure
    func loadItems() -> Observable<Result<ItemsModel, LocalError>> {
        return Observable<Result<ItemsModel, LocalError>>.just(.success(ItemsModel(items: Global.items)))
    }
}
