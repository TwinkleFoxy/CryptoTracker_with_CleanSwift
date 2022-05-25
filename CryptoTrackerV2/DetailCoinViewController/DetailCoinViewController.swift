//
//  DetailCoinViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

protocol DetailCoinDisplayLogic: AnyObject {
    func displayCoinDetails(viewModel: DetailCoin.ShowDetails.ViewModel)
    func displayFavoritStatus(viewModel: DetailCoin.SetFavoritStatus.ViewModel)
}

class DetailCoinViewController: UIViewController, DetailCoinDisplayLogic {

    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var curculatingSupplyLabel: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!
    @IBOutlet weak var high24hLabel: UILabel!
    @IBOutlet weak var low24hLabel: UILabel!
    @IBOutlet weak var priceChange24hLabel: UILabel!
    @IBOutlet weak var favoritButtonLabel: UIBarButtonItem!
    
    var interactor: DetailCoinBusinessLogic?
    var router: (NSObjectProtocol & DetailCoinRoutingLogic & DetailCoinDataPassing)?
    var detailCoinConfigurator = DetailCoinConfigurator()
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        detailCoinConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        detailCoinConfigurator.configure(viewController: self)
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passRequest()
    }
    
    
    @IBAction func favoritButtonPressed(_ sender: UIBarButtonItem) {
        interactor?.changeFavoritStatus()
    }
    
    
    // MARK: Pass request
    
    func passRequest() {
        let request = DetailCoin.ShowDetails.Request()
        interactor?.doProvideCoinDetails(request: request)
    }
    
    func displayCoinDetails(viewModel: DetailCoin.ShowDetails.ViewModel) {
        coinNameLabel.text = viewModel.coinName
        coinPriceLabel.text = viewModel.coinPrice
        marketCapLabel.text = viewModel.marketCap
        curculatingSupplyLabel.text = viewModel.curculatingSupply
        maxSupplyLabel.text = viewModel.maxSupply
        high24hLabel.text = viewModel.high24h
        low24hLabel.text = viewModel.low24h
        priceChange24hLabel.text = viewModel.priceChange24h
        favoritButtonLabel.image = viewModel.favoritStatus ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoritButtonLabel.tintColor = .systemPink
    }
    
    func displayFavoritStatus(viewModel: DetailCoin.SetFavoritStatus.ViewModel) {
        favoritButtonLabel.image = viewModel.favoritStatus ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoritButtonLabel.tintColor = .systemPink
    }
}
