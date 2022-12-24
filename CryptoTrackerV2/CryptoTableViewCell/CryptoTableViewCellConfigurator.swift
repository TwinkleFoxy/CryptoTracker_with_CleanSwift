//
//  CryptoTableViewCellConfigurator.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 24.05.2022.
//

import Foundation

class CryptoTableViewCellConfigurator {
    func configure(viewCellController: CryptoTableViewCell, viewModelCell: CellViewModelProtocol) {
        let interactor = CryptoTableViewCellInteractor(viewModelCell: viewModelCell)
        let presenter = CryptoTableViewCellPresenter()
        let router = CryptoTableViewCellRouter()
        viewCellController.interactor = interactor
        viewCellController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewCellController
        router.viewController = viewCellController
        router.dataStore = interactor
    }
}
