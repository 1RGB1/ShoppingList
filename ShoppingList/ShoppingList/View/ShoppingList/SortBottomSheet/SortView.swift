//
//  SortView.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import UIKit

enum SortBy: String {
    case name = "Name"
    case quantity = "Quantity"
    case none = ""
}

enum OrderBy: String {
    case ascending = "Asce"
    case descending = "Desc"
    case none = ""
}

protocol SortViewDelegate: AnyObject {
    func applyTapped(sortBy: SortBy, orderBy: OrderBy)
}

class SortView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var sortByButtons: [UIButton]!
    @IBOutlet var orderByButtons: [UIButton]!
    
    weak var delegate: SortViewDelegate?
    private var selectedSortBy: SortBy = .none
    private var selectedOrderBy: OrderBy = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SortView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        containerView.addBlur()
        containerView.addSubview(contentView)
        contentView.setCornerRadiusWithShadow(cornerRadius: 8)
    }
    
    @IBAction func sortByTapped(_ sender: UIButton) {
        let selectedSortBy = SortBy(rawValue: (sender.titleLabel?.text ?? ""))
        
        sortByButtons.forEach { button in
            let sortBy = SortBy(rawValue: (button.titleLabel?.text ?? ""))
            button.configuration?.background.backgroundColor = (sortBy == selectedSortBy) ? .systemRed : .systemBlue
        }
    }
    
    @IBAction func orderByTapped(_ sender: UIButton) {
        let selectedOrderBy = OrderBy(rawValue: (sender.titleLabel?.text ?? ""))
        
        orderByButtons.forEach { button in
            let orderBy = OrderBy(rawValue: (button.titleLabel?.text ?? ""))
            button.configuration?.background.backgroundColor = (orderBy == selectedOrderBy) ? .systemRed : .systemBlue
        }
    }
    
    @IBAction func applyTapped(_ sender: UIButton) {
        delegate?.applyTapped(sortBy: self.selectedSortBy, orderBy: self.selectedOrderBy)
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        clear()
    }
    
    private func clear() {
        self.selectedSortBy = .none
        self.selectedOrderBy = .none
        sortByButtons.forEach { $0.configuration?.background.backgroundColor = .systemBlue }
        orderByButtons.forEach { $0.configuration?.background.backgroundColor = .systemBlue }
    }
}
