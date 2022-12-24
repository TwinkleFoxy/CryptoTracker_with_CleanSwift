//
//  CellViewModel.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 25.05.2022.
//

import Foundation

protocol CellViewModelProtocol {
    var imageCoin: URL { get set }
    var nameCoin: String { get set }
    var priceChangePercentage24h: Double { get set }
    var priceCoin: Double { get set }
}
