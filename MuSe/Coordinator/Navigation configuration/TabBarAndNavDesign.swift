//
//  TabBarAndNavDesign.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

final class TabBarAndNavDesign {

    func configuration() {

        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = .systemGray6
        UITabBar.appearance().tintColor = UIColor(named: Colors.capsuleColor.rawValue)

        UINavigationBar.appearance().barTintColor = UIColor(named: Colors.capsuleColor.rawValue)
    }
}
