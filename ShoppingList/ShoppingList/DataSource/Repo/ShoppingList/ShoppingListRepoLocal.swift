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
    func findItem(_ query: String) -> Observable<Result<[ItemModel], LocalError>>
}

struct ShoppingListRepoLocal: ShoppingListRepoProtocol {
    
    /// To get all items list
    /// - Returns: Observable containing model in case of success and error in case of failure
    func loadItems() -> Observable<Result<ItemsModel, LocalError>> {
        if let model: ItemsModel = MockHandler().getMockModel(jsonFileName: "ItemsList") {
            return Observable<Result<ItemsModel, LocalError>>.just(.success(model))
        }
        
        return Observable<Result<ItemsModel, LocalError>>.just(.failure(LocalError.genericError()))
    }
    
    /// To find all items contains query in its name or description list
    /// - Parameters:
    ///   - query: search query to find all items related to it
    /// - Returns: Observable containing model in case of success and error in case of failure
    func findItem(_ query: String) -> Observable<Result<[ItemModel], LocalError>> {
        if let model: ItemsModel = MockHandler().getMockModel(jsonFileName: "ItemsList"),
           let items = model.items {
            
            let filtered = items.filter { ($0.name?.lowercased() ?? "").contains(query.lowercased()) || ($0.description?.lowercased() ?? "").contains(query.lowercased()) }
            
            return Observable<Result<[ItemModel], LocalError>>.just(.success(filtered))
        }
        
        return Observable<Result<[ItemModel], LocalError>>.just(.failure(LocalError.genericError()))
    }
}
