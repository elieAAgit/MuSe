//
//  AnimateButton.swift
//  MuSe
//
//  Created by Elie Arquier on 12/04/2022.
//

import UIKit

// Animated button when to use
final class AnimateButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        animated()

        return super.beginTracking(touch, with: event)
    }

    /// Add animation when button is tapped
    private func animated() {

        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { (true) in
            self.transform = .identity
        })
    }
}
