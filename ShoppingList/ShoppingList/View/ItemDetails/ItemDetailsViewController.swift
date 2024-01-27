//
//  ItemDetailsViewController.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 27/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ItemDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: Local attributes
    let disposeBag = DisposeBag()
    var viewModel: ItemDetailsViewModel?
    private var itemModel: ItemModel?
    
    // MARK: Life cycle functions
    init(viewModel: ItemDetailsViewModel = ItemDetailsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepUI()
    }
    
    // MARK: Local functions
    fileprivate func prepUI() {
        self.title = viewModel?.screenTitle
        contentView.setCornerRadiusWithShadow(cornerRadius: 8)
        nameTextField.becomeFirstResponder()
        
        guard
            let viewModel = viewModel,
            let itemModel = viewModel.itemModel
        else { return }
        
        self.itemModel = itemModel
        nameTextField.text = itemModel.name
        quantityTextField.text = "\(itemModel.quantity ?? 0)"
        descriptionTextView.text = itemModel.description
        
//        descriptionTextView.layer.borderWidth = 0.5
//        descriptionTextView.layer.borderColor = UIColor.black.cgColor
//        descriptionTextView.layer.cornerRadius = 5.0
//        descriptionTextView.backgroundColor = .blue
    }
    
    // MARK: Actions
    @IBAction func saveItemTapped(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        
        viewModel.saveItem(
            ItemModel(
                name: nameTextField.text,
                quantity: Int(quantityTextField.text ?? "0"),
                description: descriptionTextView.text,
                isBought: false
            )
        )
    }
}
