//
//  PlaceButton.swift
//  MuSe
//
//  Created by Elie Arquier on 26/04/2022.
//

import UIKit

// Custom button for the place detail page
final class PlaceButton: UIButton {

    override func awakeFromNib() {
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

