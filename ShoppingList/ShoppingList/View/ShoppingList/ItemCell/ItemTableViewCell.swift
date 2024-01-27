//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import UIKit

protocol ItemTableViewCellDelegate: BaseCellDelegate {
    func deleteTappedWithId(_ id: Int)
    func editTappedForItem(_ item: ItemModel)
    func changeStatus(_ item: ItemModel)
}

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var isBoughtButton: UIButton!
    
    weak var delegate: BaseCellDelegate?
    var viewModel: ItemCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.setCornerRadiusWithShadow(cornerRadius: 8)
        isBoughtButton.setCornerRadiusWithShadow(cornerRadius: 8)
    }
    
    @IBAction func isBoughtTapped(_ sender: UIButton) {
        if let isBought = viewModel?.itemModel.isBought, isBought {
            sender.setImage(UIImage(named: "ic_not_selected"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "ic_selected"), for: .normal)
        }
        
        viewModel?.itemModel.isBought?.toggle()
        
        guard let viewModel = viewModel else { return }
        (delegate as? ItemTableViewCellDelegate)?.changeStatus(viewModel.itemModel)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        (delegate as? ItemTableViewCellDelegate)?.editTappedForItem(viewModel.itemModel)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        (delegate as? ItemTableViewCellDelegate)?.deleteTappedWithId(viewModel.itemModel.id)
    }
}

extension ItemTableViewCell: CellConfigurable {
    func setUp(model: BaseCellViewModel) {
        guard let model = model as? ItemCellViewModel else { return }
        
        self.viewModel = model
        
        itemNameLabel.text = model.itemModel.name ?? "N/A"
        itemQuantityLabel.text = "\(model.itemModel.quantity ?? 0)"
        itemDescriptionLabel.text = model.itemModel.description ?? "N/A"
        
        if model.itemModel.isBought ?? false {
            isBoughtButton.setImage(UIImage(named: "ic_selected"), for: .normal)
        } else {
            isBoughtButton.setImage(UIImage(named: "ic_not_selected"), for: .normal)
        }
    }
}
