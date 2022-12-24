//
//  CryptoTableViewCellPresenter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 23.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CryptoTableViewCellPresentationLogic {
    func presentCoinForCell(response: CryptoTableViewCellModel.Something.Response)
}

class CryptoTableViewCellPresenter: CryptoTableViewCellPresentationLogic {
    
    weak var viewController: CryptoTableViewCellDisplayLogic?
    
    // MARK: Present coin for cell
    func presentCoinForCell(response: CryptoTableViewCellModel.Something.Response) {
        let data = response.imageCoinData ?? Data()
        let priceCoin = "\(response.priceCoin) $"
        let priceChangePercentage24h = "\(response.priceChangePercentage24h) %"
        
        let viewModel = CryptoTableViewCellModel.Something.ViewModel(imageCoinData: data,
                                                                     nameCoin: response.nameCoin,
                                                                     priceCoin: priceCoin,
                                                                     priceChangePercentage24h: priceChangePercentage24h)
        viewController?.displayCellForCoin(viewModel: viewModel)
    }
}
