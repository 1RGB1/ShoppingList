//
//  SortView.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

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
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    let disposeBag = DisposeBag()
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
        self.addBlur()
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.setCornerRadiusWithShadow(cornerRadius: 8)
        
        bindApplyButton()
        bindClearButton()
    }
    
    @IBAction func sortByTapped(_ sender: UIButton) {
        self.selectedSortBy = SortBy(rawValue: (sender.titleLabel?.text ?? "")) ?? .none
        
        sortByButtons.forEach { button in
            let sortBy = SortBy(rawValue: (button.titleLabel?.text ?? ""))
            button.configuration?.background.backgroundColor = (sortBy == self.selectedSortBy) ? .systemRed : .systemBlue
        }
    }
    
    @IBAction func orderByTapped(_ sender: UIButton) {
        self.selectedOrderBy = OrderBy(rawValue: (sender.titleLabel?.text ?? "")) ?? .none
        
        orderByButtons.forEach { button in
            let orderBy = OrderBy(rawValue: (button.titleLabel?.text ?? ""))
            button.configuration?.background.backgroundColor = (orderBy == self.selectedOrderBy) ? .systemRed : .systemBlue
        }
    }
    
    private func bindApplyButton() {
        applyButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.applyTapped(sortBy: self.selectedSortBy, orderBy: self.selectedOrderBy)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func bindClearButton() {
        clearButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.clear()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func clear() {
        self.selectedSortBy = .none
        self.selectedOrderBy = .none
        sortByButtons.forEach { $0.configuration?.background.backgroundColor = .systemBlue }
        orderByButtons.forEach { $0.configuration?.background.backgroundColor = .systemBlue }
    }
}
