//
//  HomeViewModel.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Combine

protocol HomeDelegate: AnyObject {
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
    var coinVMs: [CoinProtocol] = []
    var filteredVMs: [CoinProtocol] = []
    
    init(serviceManager: NetworkServiceProtocol = NetworkService.shared, delegate: HomeDelegate){
        self.serviceManager = serviceManager
        self.delegate = delegate
    }
    
    private func handleResponseData(data: [Coin]) {
        self.coinVMs = data.map{CoinViewModel(coin: $0)}
        self.filteredVMs = self.coinVMs
    }
    
//MARK: HomeProtocol
    func search(keyword: String) {
        if keyword.isEmpty {
            self.filteredVMs = self.coinVMs
        }else {
            self.filteredVMs = self.coinVMs.filter{$0.nameString.contains(keyword)}
        }
        self.delegate?.dataDidLoad()
    }
    
    func fetchData() {
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
