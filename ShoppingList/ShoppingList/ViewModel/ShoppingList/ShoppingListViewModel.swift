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
    private var isBought = false
    
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
    
    func deleteItemAtIndex(_ index: Int) {
        useCase.deleteItemAtIndex(index)
            .subscribe(
                onNext: { [weak self] items in
                    guard let self = self else { return }
                    self.dataSource.onNext(self.prepCellsViewModelsWithRepos(items))
                }
            )
            .disposed(by: disposeBag)
    }
    
    func sortBy(_ sortBy: SortBy, andOrderBy orderBy: OrderBy) {
        useCase.sortBy(sortBy, andOrderBy: orderBy)
            .subscribe(
                onNext: { [weak self] items in
                    guard let self = self else { return }
                    self.dataSource.onNext(self.prepCellsViewModelsWithRepos(items))
                }
            )
            .disposed(by: disposeBag)
    }
    
    func findAllBought(_ isBought: Bool) {
        self.isBought = isBought
        useCase.findAllBought(isBought)
            .subscribe(
                onNext: { [weak self] items in
                    guard let self = self else { return }
                    self.dataSource.onNext(self.prepCellsViewModelsWithRepos(items))
                }
            )
            .disposed(by: disposeBag)
    }
    
    func updateItem(_ item: ItemModel) {
        // TODO: To update the centralized data
        let savedItemIndex = Global.items.firstIndex { $0.name == item.name && $0.description == item.description }
        guard let savedItemIndex = savedItemIndex else { return }
        Global.items[savedItemIndex] = item
    }
    
    fileprivate func prepCellsViewModelsWithRepos(_ items: [ItemModel]) -> [BaseCellViewModel] {
        var cellsViewModels = [BaseCellViewModel]()
        let filtered = items.filter { $0.isBought == isBought }
        let itemsViewModels = filtered.map { ItemCellViewModel(itemModel: $0) }
        cellsViewModels.append(contentsOf: itemsViewModels)
        return cellsViewModels
    }
}
