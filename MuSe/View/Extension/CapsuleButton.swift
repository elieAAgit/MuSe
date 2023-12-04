//
//  CapsuleButton.swift
//  MuSe
//
//  Created by Elie Arquier on 12/04/2022.
//

import UIKit

// Inherits from round button with different colors properties
final class CapsuleButton: RoundButton {

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        defineColors()
    }

    // MARK: - Methods

    override var isSelected: Bool {
        didSet {
            defineColors()
        }
    }

    /// Different states colors
    override func defineColors() {
        if self.isSelected {
            setTitleColor(.white, for: .normal)
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            layer.borderWidth = 1
            backgroundColor = UIColor(named: Colors.capsuleColor.rawValue)
        } else {
            setTitleColor(UIColor(named: Colors.capsuleColor.rawValue), for: .normal)
            layer.borderColor = #colorLiteral(red: 0.4150328636, green: 0.1430818439, blue: 0.4326360822, alpha: 1)
            layer.borderWidth = 1
            backgroundColor = UIColor.systemBackground
        }
    }
}
