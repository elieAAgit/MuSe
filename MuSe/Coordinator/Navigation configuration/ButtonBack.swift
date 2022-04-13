//
//  ButtonBack.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

extension UIBarButtonItem {

    func buttonBack(name: String) {

        title = name
        style = .plain
        target = nil
        action = nil
        tintColor = .label
    }
}

