//
//  TabBarAndNavDesign.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

final class TabBarAndNavDesign {

    func configuration() {

        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .systemGray6
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = UIColor(named: Colors.capsuleColor.rawValue)

        UINavigationBar.appearance().barTintColor = .purple
        UINavigationBar.appearance().backgroundColor = UIColor(named: Colors.buttonColor.rawValue)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
