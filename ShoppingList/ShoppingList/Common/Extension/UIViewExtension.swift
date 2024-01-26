//
//  UIViewExtension.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import Foundation
import UIKit

extension UIView {
    
    /// To add both courner radius and shadow to any UIView
    /// - Parameters:
    ///   - cornerRadius:   value for view's corner
    func setCornerRadiusWithShadow(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
