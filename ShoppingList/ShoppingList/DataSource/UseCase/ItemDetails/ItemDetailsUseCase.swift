//
//  ItemDetailsUseCase.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 27/01/2024.
//

import Foundation
import RxSwift

protocol ItemDetailsUseCaseProtocol {
    func saveItem(_ item: ItemModel) -> Observable<Void>
}

struct ItemDetailsUseCase: ItemDetailsUseCaseProtocol {
    
    var repo: ItemDetailsRepoProtocol
    
    init(repo: ItemDetailsRepoProtocol = ItemDetailsRepoLocal()) {
        self.repo = repo
    }
    
    func saveItem(_ item: ItemModel) -> Observable<Void> {
        return repo.saveItem(item)
            .flatMap { result -> Observable<Void> in
                switch result {
                case .success:
                    let savedItemIndex = Global.items.firstIndex { $0.name == item.name && $0.description == item.description }
                    if let savedItemIndex = savedItemIndex {
                        Global.items[savedItemIndex] = item
                    } else {
                        Global.items.append(item)
                    }
                    
                case .failure(let error):
                    print(error.errorMsg)
                }
                
                return Observable<Void>.just(())
            }
    }
}

