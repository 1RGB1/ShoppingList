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
    @IBOutlet weak var sortView: SortView!
    
    // MARK: Local attributes
    let disposeBag = DisposeBag()
//    let viewModel = ReposFindViewModel()
    var topTableViewCellIndexPath: IndexPath?
    var isBought = false
    
    // MARK: Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortView.delegate = self
        prepUI()
        prepSearchBar()
        prepTableView()
        bindDataSourceToTableView()
    }
    
    // MARK: Delegate functions
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//
//        let visibleIndexPaths = reposTableView.indexPathsForVisibleRows?.sorted { $0.row < $1.row }
//        topTableViewCellIndexPath = visibleIndexPaths?.first
//
//        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
//            if let indexPath = self?.topTableViewCellIndexPath {
//                self?.reposTableView.scrollToRow(at: indexPath, at: .top, animated: false)
//            }
//        }
//
//        super.viewWillTransition(to: size, with: coordinator)
//    }
    
    // MARK: Local functions
    fileprivate func prepUI() {
        self.title = "Shopping List"
        itemsSearchBar.isHidden = true
        sortView.isHidden = true
    }
    
    fileprivate func prepSearchBar() {
        itemsSearchBar.becomeFirstResponder()
        itemsSearchBar.searchTextField.delegate = self
    }
    
    fileprivate func prepTableView() {
        itemsTableView.registerCell(ItemTableViewCell.self)
    }
    
    fileprivate func bindDataSourceToTableView() {
//        let searchResultObservable = reposSearchBar.rx.text
//            .orEmpty
//            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
//            .debug()
//            .flatMap { [weak self] query -> Observable<[BaseCellViewModel]> in
//                guard let self = self else { return Observable<[BaseCellViewModel]>.just([]) }
//
//                if query.isEmpty {
//                    return Observable<[BaseCellViewModel]>.just([])
//                } else {
//                    ProgressHUD.show()
//                    self.reposSearchBar.resignFirstResponder()
//                    let resultObserver = self.viewModel.findGitReposBySearchQuery(query)
//                    resultObserver.subscribe { [weak self] cellsViewModels in
//                        self?.handleSuccessState()
//                    } onError: { [weak self] in
//                        let error = $0 as? NetworkError
//                        self?.handleFailureState(error?.errorMsg ?? ErrorType.genericError.rawValue)
//                    }.disposed(by: self.disposeBag)
//
//                    return resultObserver
//                }
//            }
//            .observe(on: MainScheduler.instance)
//
//        searchResultObservable.bind(to: reposTableView.rx.items(cellIdentifier: RepoTableViewCell.self.reuseIdentifier)) { [unowned self] (row, viewModel: BaseCellViewModel, cell: RepoTableViewCell) in
//            cell.setUp(model: viewModel)
//            cell.delegate = self
//        }.disposed(by: disposeBag)
    }
    
    // MARK: Actions
    @IBAction func searchItemTapped(_ sender: UIButton) {
        itemsSearchBar.isHidden.toggle()
        itemsSearchBar.text = ""
    }
    
    @IBAction func sortListTapped(_ sender: UIButton) {
        sortView.isHidden = false
    }
    
    @IBAction func filterListValueChanged(_ sender: UISwitch) {
        self.isBought = sender.isOn
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
    }
}
