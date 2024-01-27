//
//  ItemDetailsRepoLocal.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 27/01/2024.
//

import Foundation
import RxSwift

protocol ItemDetailsRepoProtocol {
    func saveItem(_ item: ItemModel) -> Observable<Result<Void, LocalError>>
}

struct ItemDetailsRepoLocal: ItemDetailsRepoProtocol {
    
    /// To get all items list
    /// - Returns: Observable containing model in case of success and error in case of failure
    func saveItem(_ item: ItemModel) -> Observable<Result<Void, LocalError>> {
        return Observable<Result<Void, LocalError>>.just(.success(()))
    }
}
