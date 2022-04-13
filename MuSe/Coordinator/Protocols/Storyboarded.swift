//
//  Storyboarded.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {

    static func instantiate() -> Self {
        let idvc = String(describing: self)
        let idStoryboard = idvc.replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: idStoryboard, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: idStoryboard) as! Self
    }
}
