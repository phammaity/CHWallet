//
//  CoinViewModel.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Foundation

protocol CoinProtocol {
    var baseString: String {get}
    var nameString: String {get}
    var buyPriceString: String {get}
    var sellPriceString: String {get}
    var iconUrlString: String {get}
    var oldSellPrice: String? {get set}
    var oldBuyPrice: String? {get set}
}

class CoinViewModel: CoinProtocol {
    
    private var coin: Coin
    var oldSellPrice: String?
    var oldBuyPrice: String?
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var baseString: String {
        return String(format: "%@(%@)", coin.base, coin.counter)
    }
    
    var nameString: String {
        return coin.name
    }
    
    var buyPriceString: String {
        return coin.buyPrice
    }
    
    var sellPriceString: String {
        return coin.sellPrice
    }
    
    var iconUrlString: String {
        return coin.icon
    }
    
    
}
