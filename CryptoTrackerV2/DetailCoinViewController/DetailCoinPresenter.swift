//
//  DetailCoinPresenter.swift
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

protocol DetailCoinPresentationLogic {
    func presentCoinDetails(response: DetailCoin.ShowDetails.Response)
    func presentFavoritStatus(response: DetailCoin.SetFavoritStatus.Response)
}

class DetailCoinPresenter: DetailCoinPresentationLogic {
    
    weak var viewController: DetailCoinDisplayLogic?
    
    // MARK: Present coin details
    
    func presentCoinDetails(response: DetailCoin.ShowDetails.Response) {
        let coinName = "\(response.coinName)"
        let coinPrice = "\(response.coinPrice) $"
        let marketCap = "\(response.marketCap)"
        var curculatingSupplyString = ""
        if let curculatingSupply = response.curculatingSupply { curculatingSupplyString = "\(curculatingSupply)" } else {
            curculatingSupplyString = "No Data"
        }
        var maxSupplyString = ""
        if let maxSupply = response.maxSupply { maxSupplyString = "\(maxSupply)" } else {
            maxSupplyString = "No Data"
        }
        let high24h = "\(response.high24h)"
        let low24h = "\(response.low24h)"
        let priceChange24h = "\(response.priceChange24h) %"
        
        
        let viewModel = DetailCoin.ShowDetails.ViewModel(coinName: coinName,
                                                         coinPrice: coinPrice,
                                                         marketCap: marketCap,
                                                         curculatingSupply: curculatingSupplyString,
                                                         maxSupply: maxSupplyString,
                                                         high24h: high24h,
                                                         low24h: low24h,
                                                         priceChange24h: priceChange24h,
                                                         favoritStatus: response.favoritStatus)
        viewController?.displayCoinDetails(viewModel: viewModel)
    }
    
    func presentFavoritStatus(response: DetailCoin.SetFavoritStatus.Response) {
        let isFavorit = DetailCoin.SetFavoritStatus.ViewModel(favoritStatus: response.favoritStatus)
        viewController?.displayFavoritStatus(viewModel: isFavorit)
    }
}