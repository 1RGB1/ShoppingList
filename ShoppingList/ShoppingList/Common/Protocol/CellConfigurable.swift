//
//  CellConfigurable.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation
import UIKit

/// A type that handles cell's view model.
protocol CellConfigurable: UITableViewCell {
    
    /// For cell to delegate something to the one using it
    var delegate: BaseCellDelegate? { get set }
    
    /// To setup cell with its view model
    /// - Parameters:
    ///   - model:   cell's view model
    func setUp(model: BaseCellViewModel)
}
