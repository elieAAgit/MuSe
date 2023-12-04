//
//  Storyboarded.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {

    static func instantiate() -> Self {
        // Id storyboard
        let idvc = String(describing: self)
        let idStoryboard = idvc.replacingOccurrences(of: "ViewController", with: "")
        // Load storyboard
        let storyboard = UIStoryboard(name: idStoryboard, bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: idStoryboard) as! Self
    }
}
