//
//  CashData.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 26.06.2022.
//

import Foundation

class CashData {
    static let shared = CashData()
    
    private var cashCoins: [Coin] = []
    
    private init() {
        
    }
    
    func setCashCoins(for coins: [Coin]) {
        cashCoins = coins
    }
    
    func getCashCoins() -> [Coin]{
        return cashCoins
    }
    
    func cashCoinsIsEmpty() -> Bool {
        return cashCoins.isEmpty
    }
}
