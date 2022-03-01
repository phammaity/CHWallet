//
//  NetworkService.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Foundation
import Combine
import Alamofire

protocol NetworkServiceProtocol {
    func fetchPrices(currency: Currency) -> AnyPublisher<DataResponse<BaseResponse<Coin>, NetworkError>, Never>
}

class NetworkService: NetworkServiceProtocol {
    static let shared: NetworkServiceProtocol = NetworkService()
    private let urlString = "https://www.coinhako.com/api/v3/price/all_prices_for_mobile"
    private init() { }

    func fetchPrices(currency: Currency) -> AnyPublisher<DataResponse<BaseResponse<Coin>, NetworkError>, Never>{
        return fetchData(urlString: urlString)
    }
    
    func fetchData<T: Decodable>(urlString: String) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        //create request url
        let url = URL(string: urlString)!
        
        return AF.request(url,method: .get, parameters:["counter_currency":"USD"], encoding: URLEncoding.queryString)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    let systemError = response.data.flatMap {
                        try? JSONDecoder().decode(SystemError.self, from: $0)
                    }
                    return NetworkError(error: error, systemError: systemError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
