//
//  MainModels.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 24.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Main {
    
    // MARK: Use cases
    enum ShowCoinsList {
        struct Response {
            let coins: [Coin]
        }
        
        struct ViewModel {
            struct CoinCellViewModel: CellViewModelProtocol {
                var imageCoin: URL
                var nameCoin: String
                var priceChangePercentage24h: Double
                var priceCoin: Double
            }
            let coinCellViewModel: [CoinCellViewModel]
        }
    }
    
    
    enum ShowUpdateCoinList {
        struct Response {
            let coins: [Coin]
        }
        
        struct ViewModel {
            struct CoinCellViewModel: CellViewModelProtocol {
                var imageCoin: URL
                var nameCoin: String
                var priceChangePercentage24h: Double
                var priceCoin: Double
            }
            let coinCellViewModel: [CoinCellViewModel]
        }
    }
    
    
    enum ShowSearchedCoinList {
        struct Request {
            let searchText: String
        }
        
        struct Response {
            let coins: [Coin]
        }
        
        struct ViewModel {
            struct CoinCellViewModel: CellViewModelProtocol {
                var imageCoin: URL
                var nameCoin: String
                var priceChangePercentage24h: Double
                var priceCoin: Double
            }
            let coinCellViewModel: [CoinCellViewModel]
        }
    }
}
