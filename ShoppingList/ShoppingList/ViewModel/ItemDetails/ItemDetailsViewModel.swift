//
//  ItemDetailsViewModel.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 27/01/2024.
//

import Foundation
import UIKit
import RxSwift

class ItemDetailsViewModel {
    
    private var useCase: ItemDetailsUseCaseProtocol
    private let disposeBag = DisposeBag()
    var screenTitle: String?
    var itemModel: ItemModel?
    
    init(useCase: ItemDetailsUseCaseProtocol = ItemDetailsUseCase(), screenTitle: String? = "Add new item", itemModel: ItemModel? = nil) {
        self.useCase = useCase
        self.screenTitle = screenTitle
        self.itemModel = itemModel
    }
    
    func saveItem(_ item: ItemModel) {
        self.itemModel = item
        useCase.saveItem(item)
            .subscribe(
                onNext: {
                    print("Success")
                }
            )
            .disposed(by: disposeBag)
    }
}
