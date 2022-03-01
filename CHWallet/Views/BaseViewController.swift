//
//  BaseViewController.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import UIKit

class BaseViewController: UIViewController {
    func showErrorAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
