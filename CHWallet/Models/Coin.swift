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
    var buyPrice: Decimal
    var sellPrice: Decimal
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        base = try container.decode(String.self, forKey: .base)
        counter = try container.decode(String.self, forKey: .counter)
        icon = try container.decode(String.self, forKey: .icon)
        name = try container.decode(String.self, forKey: .name)
        
        let buyPriceString = try container.decode(String.self, forKey: .buyPrice)
        buyPrice = Decimal(string: buyPriceString) ?? 0
        
        let sellPriceString = try container.decode(String.self, forKey: .sellPrice)
        sellPrice = Decimal(string: sellPriceString) ?? 0
    }
}
