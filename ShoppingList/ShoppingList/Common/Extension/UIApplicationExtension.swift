//
//  UIApplicationExtension.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 27/01/2024.
//

import UIKit

extension UIApplication {
    static var topWindow: UIWindow {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene!.windows.first!
    }
}
