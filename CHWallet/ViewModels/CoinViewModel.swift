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
}

class CoinViewModel: CoinProtocol {
    
    private var coin: Coin
    
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
        return String(coin.buyPrice.description)
    }
    
    var sellPriceString: String {
        return String(coin.sellPrice.description)
    }
    
    var iconUrlString: String {
        return coin.icon
    }
}
