//
//  Coin.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Foundation

struct Coin: Codable {
    var base: String
    var counter: String
    var buyPrice: String
    var sellPrice: String
    var icon: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case base
        case counter
        case buyPrice = "buy_price"
        case sellPrice = "sell_price"
        case icon
        case name
    }
    
    init() {
        base = ""
        counter = ""
        buyPrice = ""
        sellPrice = ""
        icon = ""
        name = ""
    }
}
