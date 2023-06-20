//  NavigationBarModels.swift
//  ISS
//
//  Copyright © 2022 ISoftStone. All rights reserved.
//

import Foundation
import ISSTheme
import UIKit

public struct LeadingTitle {
    public let title: String
    public let color: UIColor
    public let font: UIFont
    public let accessibilityId: String?
    public let tintColor: UIColor?
    
    public init(title: String, color: UIColor = Theme.current.issWhite.uiColor, font: UIFont = Theme.current.subtitle2.uiFont, accessibilityId: String? = nil, tintColor: UIColor? = nil) {
        self.title = title
        self.color = color
        self.font = font
        self.accessibilityId = accessibilityId
        self.tintColor = tintColor
    }
}

public struct LeadingItems {
    private(set) var action: Action?
    private(set) var title: LeadingTitle?
    
    public init(action: Action? = nil, title: LeadingTitle? = nil) {
        self.action = action
        self.title = title
    }
}

public struct Action {
    public let image: UIImage?
    public let callback: (() -> Void)?
    public let accessibilityId: String?
    public let tintColor: UIColor?
    
    public init(image: UIImage?, callback: (() -> Void)?, accessibilityId: String?, tintColor: UIColor? = nil) {
        self.image = image
        self.callback = callback
        self.accessibilityId = accessibilityId
        self.tintColor = tintColor
    }
}

public struct TrailingItems {
    private(set) var primaryAction: Action?
    private(set) var secondaryAction: Action?
    private(set) var tertiaryAction: Action?
    
    public init(primaryAction: Action? = nil, secondaryAction: Action? = nil, tertiaryAction: Action? = nil) {
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.tertiaryAction = tertiaryAction
    }
}

public struct NavBarTitle {
    public let title: String
    public let titleColor: UIColor
    public let titleFont: UIFont
    
    public init(title: String, titleColor: UIColor, titleFont: UIFont) {
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
    }
}

public struct NavBarItems {
    private(set) var navtitle: NavBarTitle?
    private(set) var leadingItems: LeadingItems?
    private(set) var trailingItems: TrailingItems?
    private(set) var barItemsBackGroundColor: UIColor = .clear
    private(set) var navBarBackgroundColor: UIColor = .clear
    
    public init(navtitle: NavBarTitle? = nil, leadingItems: LeadingItems? = nil, trailingItems: TrailingItems? = nil, barItemsBackGroundColor: UIColor = .clear, navBarBackgroundColor: UIColor = .clear) {
        self.navtitle = navtitle
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        self.barItemsBackGroundColor = barItemsBackGroundColor
        self.navBarBackgroundColor = navBarBackgroundColor
    }
}


