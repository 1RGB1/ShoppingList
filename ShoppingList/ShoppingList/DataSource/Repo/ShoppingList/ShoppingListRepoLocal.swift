//
//  ShoppingListRepoLocal.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation
import RxSwift

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
