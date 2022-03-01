//
//  BaseResponse.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Foundation

struct BaseResponse<T:Codable>: Codable {
    var data: [T]?
}
