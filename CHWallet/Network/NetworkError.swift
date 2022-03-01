//
//  NetworkError.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let error: AFError
  let systemError: SystemError?
}

struct SystemError: Codable, Error {
    var status: String
    var errorMessage: String
}
