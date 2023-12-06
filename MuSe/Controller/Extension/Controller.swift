//
//  Controller.swift
//  MuSe
//
//  Created by Elie Arquier on 05/12/2023.
//

import UIKit

extension UIViewController {
    /// Show alert
    @objc func actionAlert(notification: Notification) {
        var message = String()

        guard let userInfo = notification.userInfo else { return }

        guard let alert = userInfo["alert"] as? Notification.Alert else { return }

        // Specific cases of alert
        switch alert {
        case .emptySelectorChoice:
            message = """
                      Aucune catégorie n'a été sélectionné.
                      Choisissez-en au moins une.
                      """
        }

        // Message
        showAlert(message: message)
    }

    /// Addition of an alert usable in all the ViewControllers
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Merci", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
