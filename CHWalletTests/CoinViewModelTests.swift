//
//  CoinViewModelTests.swift
//  CHWalletTests
//
//  Created by Ty Pham on 01/03/2022.
//

import XCTest

@testable import CHWallet

class CoinViewModelTests: XCTestCase {
    
    var sut: CoinProtocol!
    var coin: Coin!

    override func setUpWithError() throws {
        coin = Coin()
        sut = CoinViewModel(coin: coin)
    }

    override func tearDownWithError() throws {
        sut = nil
        coin = nil
        try super.tearDownWithError()
    }
    
    func testBaseString() {
        coin = Coin()
        coin.base = "LTD"
        coin.counter = "USD"
        sut = CoinViewModel(coin: coin)
        XCTAssertEqual(sut.baseString, "LTD(USD)", "base name with currency")
    }
    
    func testBuyPriceString() {
        let buyPrice = Decimal(string: "0.000234") ?? 0
        coin = Coin()
        coin.buyPrice = buyPrice
        sut = CoinViewModel(coin: coin)
        XCTAssertEqual(sut.buyPriceString, "0.000234", "full buy price value")
    }

    func testSellPriceString() {
        let sellPrice = Decimal(string: "0.000234") ?? 0
        coin = Coin()
        coin.sellPrice = sellPrice
        sut = CoinViewModel(coin: coin)
        XCTAssertEqual(sut.sellPriceString, "0.000234", "full buy price value")
    }
}
