//
//  PriceUpdateLabel.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import UIKit

class PriceUpdateLabel: UILabel {
    var startValue: Double = 0
    var endValue: Double = 0
    
    let animationDuration: Double = 1.5
    var animationStartDate = Date()
    private var decimalNumber = 0
    
    private var displayLink: CADisplayLink?
    
    func update(from oldValue: String, to newValue: String) {
        self.startValue = Double(oldValue) ?? 0
        self.endValue = Double(newValue) ?? 0
        self.decimalNumber = newValue.split(separator: ".").last?.count ?? 0
        self.animationStartDate = Date()
        self.displayLink?.add(to: .main, forMode: .default)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
    }

    @objc private func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        if elapsedTime > animationDuration {
            self.text = String(format: "%.\(decimalNumber)f", endValue)
            self.displayLink?.remove(from: .main, forMode: .default)
        }else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.text = String(format: "%.\(decimalNumber)f", value)
        }
    }
}
