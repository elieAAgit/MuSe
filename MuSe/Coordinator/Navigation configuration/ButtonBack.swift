//
//  ButtonBack.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import UIKit

extension UIBarButtonItem {

    /// Custom back button
    func buttonBack(name: String) {

        title = name
        style = .plain
        target = nil
        action = nil
        tintColor = .white
    }
}
