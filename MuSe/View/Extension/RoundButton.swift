//
//  RoundButton.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

class RoundButton: UIButton {

    // MARK: - Property

    var isActivated: Bool = false

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadius()
        defineColors()
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        animated()
        defineColors()

        return super.beginTracking(touch, with: event)
    }

    // MARK: - Methods

    /// Different states colors
    func defineColors() {
        if self.isActivated {
            setTitleColor(UIColor(named: Colors.capsuleColor.rawValue), for: .normal)
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            layer.borderWidth = 0
            backgroundColor = .systemBackground

            isActivated = false
        } else {
            setTitleColor(.label, for: .normal)
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            layer.borderWidth = 0
            backgroundColor = UIColor.systemBackground

            isActivated = true
        }
    }

    /// Add animation when button is tapped
    private func animated() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { (true) in
            self.transform = .identity
        })
    }

    /// Rounded or capsule style
    private func cornerRadius() {
        let viewHeigh = self.frame.size.height
        layer.cornerRadius = viewHeigh/2
    }
}
