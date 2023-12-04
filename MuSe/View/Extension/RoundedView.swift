//
//  RoundedView.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import UIKit

// View with rounded corners
final class RoundedView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 12
    }
}
