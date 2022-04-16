//
//  RoundButton.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

class RoundButton: UIButton {

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadius()
        defineColors()
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        animated()

        return super.beginTracking(touch, with: event)
    }

    // MARK: - Methods

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                setTitleColor(UIColor(named: Colors.capsuleColor.rawValue), for: .normal)
                layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                layer.borderWidth = 0
                backgroundColor = .systemBackground
            } else {
                setTitleColor(.label, for: .normal)
                layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                layer.borderWidth = 0
                backgroundColor = UIColor.systemBackground
            }
        }
    }

    /// Different states colors
    func defineColors() {
        if self.isSelected {
            setTitleColor(UIColor(named: Colors.capsuleColor.rawValue), for: .normal)
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            layer.borderWidth = 0
            backgroundColor = .systemBackground
        } else {
            setTitleColor(.label, for: .normal)
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            layer.borderWidth = 0
            backgroundColor = UIColor.systemBackground
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
