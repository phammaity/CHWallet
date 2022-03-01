//
//  CoinTableViewCell.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import UIKit
import Kingfisher

class CoinTableViewCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var baseLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sellPriceLabel: UILabel!
    @IBOutlet private weak var buyPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateData(viewModel: CoinProtocol) {
        baseLabel.text = viewModel.baseString
        nameLabel.text = viewModel.nameString
        sellPriceLabel.text = viewModel.sellPriceString
        buyPriceLabel.text = viewModel.buyPriceString
        if let imageUrl = URL(string: viewModel.iconUrlString) {
            iconImageView.kf.setImage(with: imageUrl,
                                       placeholder: UIImage(systemName: "circle"))
        } else {
            iconImageView.image = UIImage(systemName: "circle")
        }
    }
}
