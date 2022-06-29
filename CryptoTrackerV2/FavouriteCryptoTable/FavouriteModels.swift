//
//  FavouriteModels.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 24.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Favourite {
    
    // MARK: Use cases
    enum ShowFavouriteCoinsList {
        struct Response {
            let coins: [Coin]
        }
        
        struct ViewModel {
            struct FavouritCoinCellViewModel: CellViewModelProtocol {
                var imageCoin: URL
                var nameCoin: String
                var priceChangePercentage24h: Double
                var priceCoin: Double
            }
            let favouritCoinCellViewModel: [FavouritCoinCellViewModel]
        }
    }
    
    
    enum ShowUpdateFavouriteCoinList {
        struct Response {
            let coins: [Coin]
        }
        
        struct ViewModel {
            struct FavouritCoinCellViewModel: CellViewModelProtocol {
                var imageCoin: URL
                var nameCoin: String
                var priceChangePercentage24h: Double
                var priceCoin: Double
            }
            let favouritCoinCellViewModel: [FavouritCoinCellViewModel]
        }
    }
    
    
    enum ShowSearchedFavouriteCoinsList {
        struct Request {
            let searchText: String
        }
        
        struct Response {
            let coins: [Coin]
        }
        
        struct ViewModel {
            struct FavouriteSearchedCoinCellViewModel: CellViewModelProtocol {
                var imageCoin: URL
                var nameCoin: String
                var priceChangePercentage24h: Double
                var priceCoin: Double
            }
            let favouriteSearchedCoinCellViewModel: [FavouriteSearchedCoinCellViewModel]
        }
    }
}
