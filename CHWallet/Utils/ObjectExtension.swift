//
//  ObjectExtension.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import Foundation

extension NSObject {

    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
