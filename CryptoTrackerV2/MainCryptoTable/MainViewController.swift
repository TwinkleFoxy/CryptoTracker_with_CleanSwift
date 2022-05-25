//
//  MainViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayCoins(viewModel: Main.ShowCoinsList.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var viewModelCell: [Main.ShowCoinsList.ViewModel.CoinCellViewModel] = []
    
    
    var refrashControll: UIRefreshControl = {
        let refrashControll = UIRefreshControl()
        refrashControll.tintColor = .systemPink
        refrashControll.addTarget(self, action: #selector(refrashDataControll), for: .valueChanged)
        return refrashControll
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
        tableView.refreshControl = refrashControll
        getListCoins()
    }
    
    
    // MARK: RefrashControll
    
    @objc func refrashDataControll() {
        getListCoins()
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
    
    // MARK: Do something
    
    func getListCoins() {
        interactor?.fetchListCoins()
    }
    
    func displayCoins(viewModel: Main.ShowCoinsList.ViewModel) {
        viewModelCell = viewModel.coinCellViewModel
        refrashControll.endRefreshing()
        DispatchQueue.main.async { [unowned self] in
            tableView.reloadData()
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

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMainController") as! CryptoTableViewCell
        cell.cryptoTableViewCellConfigurator.configure(viewCellController: cell, viewModelCell: viewModelCell[indexPath.row])
        cell.getDataForCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
