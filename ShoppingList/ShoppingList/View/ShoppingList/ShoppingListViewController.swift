//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Ahmad Ragab on 26/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingListViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var itemsSearchBar: UISearchBar!
    @IBOutlet weak var itemsTableView: UITableView!
    
    // MARK: Local attributes
    let disposeBag = DisposeBag()
    let viewModel = ShoppingListViewModel()
    var sortView = SortView()
    var isBought = false
    
    // MARK: Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepUI()
        prepSearchBar()
        prepTableView()
        bindDataSourceToTableView()
        bindSearchBarToTableView()
        
        viewModel.loadItems()
    }
    
    // MARK: Local functions
    fileprivate func prepUI() {
        self.title = "Shopping List"
        itemsSearchBar.isHidden = true
        
        sortView = SortView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        sortView.delegate = self
        sortView.isHidden = true
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(sortView)
    }
    
    fileprivate func prepSearchBar() {
        itemsSearchBar.becomeFirstResponder()
        itemsSearchBar.searchTextField.delegate = self
    }
    
    fileprivate func prepTableView() {
        itemsTableView.registerCell(ItemTableViewCell.self)
    }
    
    fileprivate func bindDataSourceToTableView() {
        viewModel.dataSource
            .bind(to: itemsTableView.rx.items(cellIdentifier: ItemTableViewCell.self.reuseIdentifier)) { (row, viewModel: BaseCellViewModel, cell: ItemTableViewCell) in
                cell.setUp(model: viewModel, row: row)
                cell.delegate = self
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSearchBarToTableView() {
        itemsSearchBar.rx.text
            .orEmpty
            .subscribe(
                onNext: { [weak self] query in
                    guard let self = self else { return }
                    self.viewModel.findItem(query)
                }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    @IBAction func searchItemTapped(_ sender: UIButton) {
        itemsSearchBar.isHidden.toggle()
        itemsSearchBar.text = ""
    }
    
    @IBAction func sortListTapped(_ sender: UIButton) {
        sortView.isHidden.toggle()
    }
    
    @IBAction func filterListValueChanged(_ sender: UISwitch) {
        self.isBought = sender.isOn
        viewModel.findAllBought(sender.isOn)
    }
    
    @IBAction func addNewItemTapped(_ sender: UIBarButtonItem) {
    }
}

// MARK: Extensions
extension ShoppingListViewController: UITextFieldDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension ShoppingListViewController: SortViewDelegate {
    func applyTapped(sortBy: SortBy, orderBy: OrderBy) {
        sortView.isHidden = true
        viewModel.sortBy(sortBy, andOrderBy: orderBy)
    }
}

extension ShoppingListViewController: ItemTableViewCellDelegate {
    func editTappedAtIndex(_ index: Int) {
    }
    
    func deleteTappedAtIndex(_ index: Int) {
        viewModel.deleteItemAtIndex(index)
    }
    
    func changeStatus(_ item: ItemModel) {
        viewModel.updateItem(item)
        viewModel.findAllBought(self.isBought)
    }
}
