//
//  CapsuleButton.swift
//  MuSe
//
//  Created by Qattus on 12/04/2022.
//

import UIKit

final class CapsuleButton: RoundButton {

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        defineColors()
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        defineColors()

        return super.beginTracking(touch, with: event)
    }

    // MARK: - Methods

    /// Different states colors
    override func defineColors() {
        if self.isActivated {
            setTitleColor(.white, for: .normal)
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            layer.borderWidth = 1
            backgroundColor = UIColor(named: Colors.capsuleColor.rawValue)

            isActivated = false
        } else {
            setTitleColor(UIColor(named: Colors.capsuleColor.rawValue), for: .normal)
            layer.borderColor = #colorLiteral(red: 0.4150328636, green: 0.1430818439, blue: 0.4326360822, alpha: 1)
            layer.borderWidth = 1
            backgroundColor = UIColor.systemBackground

            isActivated = true
        }
    }
}
