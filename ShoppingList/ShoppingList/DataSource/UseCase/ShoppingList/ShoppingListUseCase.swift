//
//  ShoppingListUseCase.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation
import RxSwift

protocol ShoppingListUseCaseProtocol {
    func loadItems() -> Observable<[ItemModel]>
    func findItem(_ query: String) -> Observable<[ItemModel]>
}

struct ShoppingListUseCase: ShoppingListUseCaseProtocol {
    
    var repo: ShoppingListRepoProtocol
    
    init(repo: ShoppingListRepoProtocol = ShoppingListRepoLocal()) {
        self.repo = repo
    }
    
    /// To get all items list
    /// - Returns: Observable containing model in case of success and error in case of failure
    func loadItems() -> Observable<[ItemModel]> {
        return mapToItems(repo.loadItems())
    }
    
    func findItem(_ query: String) -> Observable<[ItemModel]> {
        return repo.findItem(query)
            .flatMap { (result: Result<[ItemModel], LocalError>) -> Observable<[ItemModel]> in
                switch result {
                case .success(let items):
                    return Observable<[ItemModel]>.just(items)
                case .failure(let error):
                    return Observable<[ItemModel]>.error(error)
                }
            }
    }
    
    /// To map observable to observable
    /// - Parameters:
    ///   - observable: Observable containing model in case of success and network error in case of failure
    /// - Returns: Observable containing array of repo model
    private func mapToItems(_ observable: Observable<Result<ItemsModel, LocalError>>) -> Observable<[ItemModel]> {
        observable.flatMap { (result: Result<ItemsModel, LocalError>) -> Observable<[ItemModel]> in
            switch result {
            case .success(let model):
                return Observable<[ItemModel]>.just(model.items ?? [])
            case .failure(let error):
                return Observable<[ItemModel]>.error(error)
            }
        }
    }
}
