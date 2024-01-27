//
//  ErrorModel.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation

/// Base struct for network error
struct LocalError: Error {
    
    /// Not the default network error message, it is defined when using it
    let errorMsg: String
    
    /// Generic error message
    static let genericError = {
        LocalError(errorMsg: ErrorType.genericError.rawValue)
    }
    
    /// Generic error message
    static let tryAgainError = {
        LocalError(errorMsg: ErrorType.tryAgainError.rawValue)
    }
}

enum ErrorType: String {
    case genericError = "Something went wrong"
    case tryAgainError = "Try again later"
    case parsingFaild = "Failed in parsing data"
    case requestFailed = "Error processing request"
    case badToken = "Failed to retrieve token"
    case authFailed = "Failed to authenticate"
}
