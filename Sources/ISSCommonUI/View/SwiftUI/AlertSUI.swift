//
//  AlertSUI.swift
//  
//
//  Created by Wing Seng Chew on 21/09/2023.
//

import SwiftUI

public struct AlertInfo {
    public var title: Text?
    public var message: Text
    public var dismissText: String?
    public var onDismiss: (() -> Void)?
    
    public init(title: Text? = nil, message: Text, dismissText: String? = "OK", onDismiss: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.dismissText = dismissText
        self.onDismiss = onDismiss
    }
}

public func AlertSUI(alertInfo: AlertInfo) -> Alert {
    let alert: Alert
    let dismissText = alertInfo.dismissText ?? "OK" // Use "OK" if dismissText is nil
    
    switch alertInfo.title {
    case .some(let title):
        let dismissButton = Alert.Button.default(Text(dismissText), action: {
            alertInfo.onDismiss?() // Call the closure if it's not nil
        })
        alert = Alert(title: title, message: alertInfo.message, dismissButton: dismissButton)
    case .none:
        let dismissButton = Alert.Button.default(Text(dismissText), action: {
            alertInfo.onDismiss?() // Call the closure if it's not nil
        })
        alert = Alert(message: alertInfo.message, dismissButton: dismissButton)
    }
    return alert
}
