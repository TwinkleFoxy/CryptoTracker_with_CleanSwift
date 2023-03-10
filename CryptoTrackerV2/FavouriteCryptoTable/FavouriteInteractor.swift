//
//  FavouriteInteractor.swift
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

protocol FavouriteBusinessLogic {
    func featchFavouriteCoins()
    func updateFavouriteCoins()
    func featchFavouritSearchedCoins(request: Favourite.ShowSearchedFavouriteCoinsList.Request)
}

protocol FavouriteDataStore {
    var favouritCoins: [Coin] { get }
    var favouritSearshedCoins: [Coin] { get }
    var isSearching: Bool { get }
}

class FavouriteInteractor: FavouriteBusinessLogic, FavouriteDataStore {
    
    var presenter: FavouritePresentationLogic?
    var favouritCoins: [Coin] = []
    var favouritSearshedCoins: [Coin] = []
    private var searchText: String = ""
    private var isUpdating: Bool = false
    var isSearching: Bool = false
    
    
    //MARK: Request NetWork for favourite coins
    private func requestNetWork(clouser: @escaping () -> ()) {
        NetworkManager.shared.fetchData { [unowned self] coins in
            CashData.shared.setCashCoins(for: coins)
            checkFavouritStatus(for: coins)
            clouser()
        }
    }
    
    // MARK: Update coins data from RefrashControl
    func updateFavouriteCoins(){
        requestNetWork { [unowned self] in
            isUpdating = true
            pushPresent()
        }
    }
    
    // MARK: Featch favourit coins then ViewWillAppear
    func featchFavouriteCoins() {
        if CashData.shared.cashCoinsIsEmpty() {
            requestNetWork { [unowned self] in
                pushPresent()
            }
        } else {
            checkFavouritStatus(for: CashData.shared.getCashCoins())
            pushPresent()
        }
    }
    
    // MARK: Featch favourit then search coins
    func featchFavouritSearchedCoins(request: Favourite.ShowSearchedFavouriteCoinsList.Request) {
        searchText = request.searchText
        isSearching = !searchText.isEmpty
        featchFavouriteCoins()
        searchCoins(by: searchText)
    }
}


extension FavouriteInteractor {
    
    //MARK: Present and search func
    private func searchCoins(by searchText: String) {
        favouritSearshedCoins = favouritCoins.filter { coin in
            coin.name.lowercased().contains(searchText.lowercased())
        }
        pushPresent()
    }
    
    //MARK: Check favourit status
    private func checkFavouritStatus(for coins: [Coin]) {
        favouritCoins = coins.filter({ coin in
            DataManager.shared.getFavoriteStatus(for: coin.name)
        })
    }
    
    //MARK: Transmits coins to presenter
    private func pushPresent() {
        if isSearching {
            isUpdating = false
            let responce = Favourite.ShowSearchedFavouriteCoinsList.Response(coins: favouritSearshedCoins)
            presenter?.presentSearchedFavouriteCoins(response: responce)
            
        }else if isUpdating {
            isUpdating = false
            let responce = Favourite.ShowUpdateFavouriteCoinList.Response(coins: favouritCoins)
            presenter?.presentUpdatedFavouriteCoins(responce: responce)
        }else {
            let responce = Favourite.ShowFavouriteCoinsList.Response(coins: favouritCoins)
            presenter?.presentfavouriteCoins(response: responce)
        }
    }
}
