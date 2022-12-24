//
//  TableViewCellForMainTable.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

protocol CryptoTableViewCellDisplayLogic: AnyObject {
    func displayCellForCoin(viewModel: CryptoTableViewCellModel.Something.ViewModel)
}

class CryptoTableViewCell: UITableViewCell, CryptoTableViewCellDisplayLogic {

    @IBOutlet weak var imageCoinView: UIImageView!
    @IBOutlet weak var nameCoinLabel: UILabel!
    @IBOutlet weak var priceChangePercentage24hLabel: UILabel!
    @IBOutlet weak var priceCoinLabel: UILabel!
    
    var interactor: CryptoTableViewCellBusinessLogic?
    var router: (NSObjectProtocol & CryptoTableViewCellRoutingLogic & CryptoTableViewCellDataPassing)?
    var cryptoTableViewCellConfigurator = CryptoTableViewCellConfigurator()
    
    
    // MARK: Object lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Get data for cell
    func setupCell() {
        let request = CryptoTableViewCellModel.Something.Request()
        interactor?.provideCoinForCell(request: request)
    }
    
    func displayCellForCoin(viewModel: CryptoTableViewCellModel.Something.ViewModel) {
        imageCoinView.image = UIImage(data: viewModel.imageCoinData)
        nameCoinLabel.text = viewModel.nameCoin
        priceChangePercentage24hLabel.text = viewModel.priceChangePercentage24h
        priceCoinLabel.text = viewModel.priceCoin
    }
}
