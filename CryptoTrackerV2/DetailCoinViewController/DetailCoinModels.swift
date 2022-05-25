//
//  DetailCoinModels.swift
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

enum DetailCoin {
    // MARK: Use cases
    
    enum ShowDetails {
        struct Request {
        }
        
        struct Response {
            let coinName: String
            let coinPrice: Double
            let marketCap: Int
            let curculatingSupply: Double?
            let maxSupply: Double?
            let high24h: Double
            let low24h: Double
            let priceChange24h: Double
            let favoritStatus: Bool
        }
        
        struct ViewModel {
            let coinName: String
            let coinPrice: String
            let marketCap: String
            let curculatingSupply: String
            let maxSupply: String
            let high24h: String
            let low24h: String
            let priceChange24h: String
            let favoritStatus: Bool
        }
    }
    
    enum SetFavoritStatus {
        
        struct Response {
            let favoritStatus: Bool
        }
        
        struct ViewModel {
            let favoritStatus: Bool
        }
    }
}