//
//  MainViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayCoins(viewModel: Main.ShowCoinsList.ViewModel)
    func displayUpdatedCoins(viewModel: Main.ShowUpdateCoinList.ViewModel)
    func displaySearchedCoins(viewModel: Main.ShowSearchedCoinList.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var viewModelCell: [CellViewModelProtocol] = []
    
    
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemPink
        return refreshControl
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getListCoins()
    }
    
    //MARK: SetupUI
    func setupUI() {
        tableView.refreshControl = refreshControl
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        refreshControl.addTarget(self, action: #selector(refreshDataControl), for: .valueChanged)
        refreshControl.beginRefreshing()
    }
    
    
    // MARK: Refresh control func
    @objc func refreshDataControl() {
        interactor?.updateCoins()
    }
    
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Get list coins
    func getListCoins() {
        interactor?.fetchListCoins()
    }
    
    //MARK: Display coins
    func displayCoins(viewModel: Main.ShowCoinsList.ViewModel) {
        viewModelCell = viewModel.coinCellViewModel
        DispatchQueue.main.async { [unowned self] in
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    //MARK: Display updated coins
    func displayUpdatedCoins(viewModel: Main.ShowUpdateCoinList.ViewModel) {
        viewModelCell = viewModel.coinCellViewModel
        DispatchQueue.main.async { [unowned self] in
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    //MARK: Display searched coins
    func displaySearchedCoins(viewModel: Main.ShowSearchedCoinList.ViewModel) {
        viewModelCell = viewModel.coinCellViewModel
        DispatchQueue.main.async { [unowned self] in
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMainController") as! CryptoTableViewCell
        cell.cryptoTableViewCellConfigurator.configure(viewCellController: cell, viewModelCell: viewModelCell[indexPath.row])
        cell.setupCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let request = Main.ShowSearchedCoinList.Request(searchText: searchText)
        interactor?.featchSearchedCoins(request: request)
    }
}
