//
//  ReusableProtocol.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

/// A type that handles cell's reuse identifier to make it easy for users if they forgot to add identifier to a cell.
protocol Reusable {
    /// Cell reuse identifier
    static var reuseIdentifier: String { get }
}

extension Reusable {
    /// To convert and return the class name in string fotmate
    static var reuseIdentifier: String {
        return String(describing: self)
    } 
}
