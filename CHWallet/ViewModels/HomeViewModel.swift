//
//  HomeViewModel.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Combine
import Foundation

protocol HomeDelegate: AnyObject {
    func startLoading()
    func dataDidLoad()
    func dataLoadError(error: String)
}

protocol HomeProtocol: AnyObject {
    func numberOfRows() -> Int
    func coinVM(at index: Int) -> CoinProtocol
    func fetchData()
    func search(keyword: String)
}

class HomeViewModel: HomeProtocol {
    private var cancellableSet: Set<AnyCancellable> = []
    private var serviceManager: NetworkServiceProtocol
    private weak var delegate: HomeDelegate?
    var searchKeyWord: String = ""
    var oldCoinVMs: [String:CoinProtocol] = [:]
    var coinVMs: [CoinProtocol] = []
    var filteredVMs: [CoinProtocol] = []
    
    private var timer: Timer?
    
    init(serviceManager: NetworkServiceProtocol = NetworkService.shared, delegate: HomeDelegate){
        self.serviceManager = serviceManager
        self.delegate = delegate
        
        //create timer
        self.timer = Timer.scheduledTimer(timeInterval: 30.0,
                                     target: self,
                                     selector: #selector(updatePrices),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updatePrices() {
        self.fetchData()
    }
    
    private func handleResponseData(data: [Coin]) {
        self.coinVMs = data.map({ coin in
            let coinVM = CoinViewModel(coin: coin)
            coinVM.oldBuyPrice = self.oldCoinVMs[coinVM.baseString]?.buyPriceString
            coinVM.oldSellPrice = self.oldCoinVMs[coinVM.baseString]?.sellPriceString
            return coinVM
        })
        
        self.oldCoinVMs.removeAll()
        
        self.coinVMs.forEach { item in
            self.oldCoinVMs[item.baseString] = item
        }
        
        if self.searchKeyWord.isEmpty {
            self.filteredVMs = self.coinVMs
        }else {
            self.filteredVMs = self.coinVMs.filter{$0.nameString.contains(searchKeyWord)}
        }
    }
    
//MARK: HomeProtocol
    func search(keyword: String) {
        self.searchKeyWord = keyword
        if self.searchKeyWord.isEmpty {
            self.filteredVMs = self.coinVMs
        }else {
            self.filteredVMs = self.coinVMs.filter{$0.nameString.contains(searchKeyWord)}
        }
        self.delegate?.dataDidLoad()
    }
    
    func fetchData() {
        self.delegate?.startLoading()
        serviceManager.fetchPrices(currency: Currency.usd)
            .sink {[weak self] (response) in
                if let _ = response.error {
                    self?.delegate?.dataLoadError(error: "System error")
                }else {
                    self?.handleResponseData(data: response.value?.data ?? [])
                    self?.delegate?.dataDidLoad()
                }
            }
            .store(in: &cancellableSet)
    }
    
    func numberOfRows() -> Int {
        return self.filteredVMs.count
    }
    
    func coinVM(at index: Int) -> CoinProtocol {
        return self.filteredVMs[index]
    }
}
