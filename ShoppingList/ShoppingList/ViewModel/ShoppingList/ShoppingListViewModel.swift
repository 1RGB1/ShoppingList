//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation
import UIKit
import RxSwift

class ShoppingListViewModel {
    
    private var useCase: ShoppingListUseCaseProtocol
    var dataSource = PublishSubject<[BaseCellViewModel]>()
    private let disposeBag = DisposeBag()
    
    init(useCase: ShoppingListUseCaseProtocol = ShoppingListUseCase()) {
        self.useCase = useCase
    }
    
    func loadItems() {
        useCase.loadItems()
            .subscribe(
                onNext: { [weak self] items in
                    guard let self = self else { return }
                    self.dataSource.onNext(self.prepCellsViewModelsWithRepos(items))
                }
            )
            .disposed(by: disposeBag)
    }
    
    func findItem(_ query: String) {
        useCase.findItem(query)
            .subscribe(
                onNext: { [weak self] items in
                    guard let self = self else { return }
                    self.dataSource.onNext(self.prepCellsViewModelsWithRepos(items))
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func prepCellsViewModelsWithRepos(_ items: [ItemModel]) -> [BaseCellViewModel] {
        
        var cellsViewModels = [BaseCellViewModel]()
        
        let itemsViewModels = items.map {
            ItemCellViewModel(itemModel: $0)
        }
        
        cellsViewModels.append(contentsOf: itemsViewModels)
        
        return cellsViewModels
    }
}
