//
//  Notification.swift
//  MuSe
//
//  Created by Elie Arquier on 05/12/2023.
//

import Foundation

extension Notification {
    /// Cases of alerts
    enum Alert {
        case emptySelectorChoice
    }

    /// To sent an alert
    static func alertNotification(_ alert: Alert) {
        NotificationCenter.default.post(name: .alertName, object: nil, userInfo: ["alert": alert])
    }
}

extension Notification.Name {
    /// Alert name
    static let alertName = Notification.Name("alert")
}
