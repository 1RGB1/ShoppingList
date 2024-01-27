//
//  ShoppingListUseCaseSuccessMock.swift
//  ShoppingListTests
//
//  Created by Ahmad Ragab on 27/01/2024.
//

import Foundation
import RxSwift
@testable import ShoppingList

class ShoppingListUseCaseSuccessMock: ShoppingListUseCaseProtocol {
    
    func loadItems() -> Observable<[ItemModel]> {
        var observable = Observable<[ItemModel]>.just([])
        if let model: ItemsModel = MockHandler().getMockModel(jsonFileName: "ItemsList") {
            if let items = model.items {
                observable = Observable<[ItemModel]>.just(items)
            }
        }
        
        return observable
    }
    
    func findItem(_ query: String) -> Observable<[ItemModel]> {
        var observable = Observable<[ItemModel]>.just([])
        if let model: ItemsModel = MockHandler().getMockModel(jsonFileName: "ItemsList") {
            if let items = model.items {
                observable = Observable<[ItemModel]>.just([items[0]])
            }
        }
        
        return observable
    }
    
    func deleteItemAtIndex(_ index: Int) -> Observable<[ItemModel]> {
        var observable = Observable<[ItemModel]>.just([])
        if let model: ItemsModel = MockHandler().getMockModel(jsonFileName: "ItemsList") {
            if let items = model.items {
                var updated = items
                updated.remove(at: 0)
                observable = Observable<[ItemModel]>.just(updated)
            }
        }
        
        return observable
    }
    
    func findAllBought(_ isBought: Bool) -> Observable<[ItemModel]> {
        var observable = Observable<[ItemModel]>.just([])
        if let model: ItemsModel = MockHandler().getMockModel(jsonFileName: "ItemsList") {
            if let items = model.items {
                observable = Observable<[ItemModel]>.just([items[2]])
            }
        }
        
        return observable
    }
    
    func sortBy(_ sortBy: SortBy, andOrderBy orderBy: OrderBy) -> Observable<[ItemModel]> {
        var observable = Observable<[ItemModel]>.just([])
        if let model: ItemsModel = MockHandler().getMockModel(jsonFileName: "SortedItemsList") {
            if let items = model.items {
                observable = Observable<[ItemModel]>.just(items)
            }
        }
        
        return observable
    }
}

