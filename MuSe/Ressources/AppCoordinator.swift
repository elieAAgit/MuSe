//
//  AppCoordinator.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

final class AppCoordinator {

    // MARK: - Private properties

    private unowned var sceneDelegate: SceneDelegate
    private unowned var windowScene: UIWindowScene

    // MARK: - Initializer

    init(sceneDelegate: SceneDelegate, windowScene: UIWindowScene) {

        self.sceneDelegate = sceneDelegate
        self.windowScene = windowScene
    }

    // MARK: - Coordinator

    func start() {

        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)

        sceneDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appWindow.windowScene = windowScene
        appWindow.rootViewController = TabBarController()
        appWindow.makeKeyAndVisible()
        sceneDelegate.window = appWindow

        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" { return }
    }
}
