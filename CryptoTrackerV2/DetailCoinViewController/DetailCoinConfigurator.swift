//
//  DetailCoinConfigurator.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 23.05.2022.
//

import Foundation

class DetailCoinConfigurator {
    func configure(viewController: DetailCoinViewController) {
        let interactor = DetailCoinInteractor()
        let presenter = DetailCoinPresenter()
        let router = DetailCoinRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
