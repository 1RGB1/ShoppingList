//
//  ItemCellViewModel.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation
import UIKit

struct ItemCellViewModel: BaseCellViewModel {
    
    var itemModel: ItemModel
    
    init(itemModel: ItemModel) {
        self.itemModel = itemModel
    }
}
