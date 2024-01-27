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
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterSwitch: UISwitch!
    
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
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadItems()
    }
    
    // MARK: Local functions
    fileprivate func prepUI() {
        self.title = "Shopping List"
        itemsSearchBar.isHidden = true
        
        sortView = SortView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        sortView.delegate = self
        sortView.isHidden = true
        
        UIApplication.topWindow.addSubview(sortView)
    }
    
    fileprivate func prepSearchBar() {
        itemsSearchBar.becomeFirstResponder()
    }
    
    fileprivate func prepTableView() {
        itemsTableView.registerCell(ItemTableViewCell.self)
    }
    
    fileprivate func bindViews() {
        bindSearchBarToTableView()
        bindDataSourceToTableView()
        bindSearchButton()
        bindSortButton()
        bindFilterSwitch()
        bindAddItemButton()
    }
    
    fileprivate func bindDataSourceToTableView() {
        viewModel.dataSource
            .bind(to: itemsTableView.rx.items(cellIdentifier: ItemTableViewCell.self.reuseIdentifier)) { (row, viewModel: BaseCellViewModel, cell: ItemTableViewCell) in
                cell.setUp(model: viewModel)
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
    fileprivate func bindSearchButton() {
        searchButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.itemsSearchBar.isHidden.toggle()
                    self.itemsSearchBar.text = ""
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSortButton() {
        sortButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.sortView.isHidden.toggle()
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindFilterSwitch() {
        filterSwitch
            .rx
            .controlEvent(.valueChanged)
            .withLatestFrom(filterSwitch.rx.value)
            .subscribe(
                onNext: { [weak self] isOn in
                    guard let self = self else { return }
                    self.isBought = isOn
                    self.viewModel.findAllBought(isOn)
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindAddItemButton() {
        addItemButton
            .rx
            .tap
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    let story = UIStoryboard(name: "Main", bundle: .main)
                    guard let itemDetailsViewController = story.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController else { return }
                    itemDetailsViewController.viewModel = ItemDetailsViewModel()
                    self.navigationController?.pushViewController(itemDetailsViewController, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
}

extension ShoppingListViewController: SortViewDelegate {
    func applyTapped(sortBy: SortBy, orderBy: OrderBy) {
        sortView.isHidden = true
        viewModel.sortBy(sortBy, andOrderBy: orderBy)
    }
}

extension ShoppingListViewController: ItemTableViewCellDelegate {
    func editTappedForItem(_ item: ItemModel) {
        let story = UIStoryboard(name: "Main", bundle: .main)
        guard let itemDetailsViewController = story.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController else { return }
        itemDetailsViewController.viewModel = ItemDetailsViewModel(screenTitle: "Edit item", itemModel: item)
        self.navigationController?.pushViewController(itemDetailsViewController, animated: true)
    }
    
    func deleteTappedWithId(_ id: Int) {
        viewModel.deleteItemWithId(id)
    }
    
    func changeStatus(_ item: ItemModel) {
        viewModel.updateItem(item)
        viewModel.findAllBought(self.isBought)
    }
}
