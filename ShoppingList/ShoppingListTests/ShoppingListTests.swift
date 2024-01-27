//
//  ShoppingListTests.swift
//  ShoppingListTests
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import XCTest
import RxSwift
@testable import ShoppingList

class ShoppingListTests: XCTestCase {

    var successMockUseCase: ShoppingListUseCaseProtocol = ShoppingListUseCaseSuccessMock()
    var viewModel: ShoppingListViewModel?
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    func test_SuccessMock() {
        viewModel = ShoppingListViewModel(useCase: successMockUseCase)
        XCTAssertNotNil(viewModel)
        
        viewModel!.sortBy(.quantity, andOrderBy: .ascending)
        viewModel!.dataSource.subscribe { cellsViewModels in
            let _ = cellsViewModels.map { models in
                for model in models {
                    XCTAssertNotNil(model as? ItemCellViewModel)
                }
            }
        }
        .disposed(by: disposeBag)
    }
}
