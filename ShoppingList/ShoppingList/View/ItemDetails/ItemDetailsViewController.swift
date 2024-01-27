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
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: Local attributes
    let disposeBag = DisposeBag()
    var viewModel: ItemDetailsViewModel?
    private var itemModel: ItemModel?
    
    // MARK: Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepUI()
        bindSaveButton()
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
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 240.0/255, green: 240.0/255, blue: 240/255, alpha: 1).cgColor
        descriptionTextView.layer.cornerRadius = 5.0
    }
    
    // MARK: Actions
    private func bindSaveButton() {
        saveButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    guard let viewModel = self.viewModel else { return }
                    
                    var id = Int.random(in: 0..<Int.max)
                    if let itemModel = self.itemModel {
                        id = itemModel.id
                    }
                    
                    viewModel.saveItem(
                        ItemModel(
                            id: id,
                            name: self.nameTextField.text,
                            quantity: Int(self.quantityTextField.text ?? "0"),
                            description: self.descriptionTextView.text,
                            isBought: false
                        )
                    )
                    self.navigationController?.popViewController(animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
}
