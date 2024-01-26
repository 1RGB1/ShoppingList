//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import UIKit

protocol ItemTableViewCellDelegate: BaseCellDelegate {
    func deleteTappedAtIndex(_ index: Int)
    func editTappedAtIndex(_ index: Int)
}

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var isBoughtButton: UIButton!
    
    weak var delegate: BaseCellDelegate?
    var viewModel: ItemCellViewModel?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.setCornerRadiusWithShadow(cornerRadius: 8)
        isBoughtButton.setCornerRadiusWithShadow(cornerRadius: 8)
    }
    
    @IBAction func isBoughtTapped(_ sender: UIButton) {
        if let isBought = viewModel?.itemModel.isBought, isBought {
            sender.setImage(nil, for: .normal)
        } else {
            sender.setImage(UIImage(named: "ic_selected"), for: .normal)
        }
        
        viewModel?.itemModel.isBought?.toggle()
    }
    
    @IBAction func editTapped(_ sender: Any) {
        guard let index = index else { return }
        (delegate as? ItemTableViewCellDelegate)?.editTappedAtIndex(index)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        guard let index = index else { return }
        (delegate as? ItemTableViewCellDelegate)?.deleteTappedAtIndex(index)
    }
}

extension ItemTableViewCell: CellConfigurable {
    func setUp(model: BaseCellViewModel, row: Int) {
        guard let model = model as? ItemCellViewModel else { return }
        
        self.index = row
        self.viewModel = model
        
        itemNameLabel.text = model.itemModel.name ?? "N/A"
        itemQuantityLabel.text = "\(model.itemModel.quantity ?? 0)"
        itemDescriptionLabel.text = model.itemModel.description ?? "N/A"
        
        if model.itemModel.isBought ?? false {
            isBoughtButton.setImage(UIImage(named: "ic_selected"), for: .normal)
        } else {
            isBoughtButton.setImage(nil, for: .normal)
        }
    }
}

