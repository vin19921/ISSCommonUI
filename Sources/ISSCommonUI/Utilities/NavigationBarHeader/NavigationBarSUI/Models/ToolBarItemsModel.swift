//
//  ToolBarItemsModel.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import ISSTheme
import SwiftUI

/// NavBarItemList allows us to add Nav bar items on  left, center, right of nav bar.
public class ToolBarItemsDataBuilder {
    
    public struct ToolBarItemsData {
        let leftAlignedItem: ToolBarItemDataBuilder.ToolBarItemData?
        let leftAlignedSecondItem: ToolBarItemDataBuilder.ToolBarItemData?
        let centerAlignedItem: ToolBarItemDataBuilder.ToolBarItemData?
        let rightAlignedItem: ToolBarItemDataBuilder.ToolBarItemData?
        let rightAlignedSecondItem: ToolBarItemDataBuilder.ToolBarItemData?
        let rightAlignedThirdItem: ToolBarItemDataBuilder.ToolBarItemData?
    }
    
    // MARK: - Private properties
    private(set) var leftAlignedItem: ToolBarItemDataBuilder.ToolBarItemData? = nil
    private(set) var leftAlignedSecondItem: ToolBarItemDataBuilder.ToolBarItemData? = nil
    
    private(set) var centerAlignedItem: ToolBarItemDataBuilder.ToolBarItemData? = nil
    private(set) var rightAlignedItem: ToolBarItemDataBuilder.ToolBarItemData? = nil
    private(set) var rightAlignedSecondItem: ToolBarItemDataBuilder.ToolBarItemData? = nil
    
    private(set) var rightAlignedThirdItem: ToolBarItemDataBuilder.ToolBarItemData? = nil
    
    // MARK: - Intializer
    public init() {}
    
    // MARK: - Public functions
    
    public func setLeftAlignedItem(_ leftAlignedItem: ToolBarItemDataBuilder.ToolBarItemData) -> ToolBarItemsDataBuilder {
        self.leftAlignedItem = leftAlignedItem
        return self
    }
    
    public func setLeftAlignedSecondItem(_ leftAlignedSecondItem: ToolBarItemDataBuilder.ToolBarItemData) -> ToolBarItemsDataBuilder {
        self.leftAlignedSecondItem = leftAlignedSecondItem
        return self
    }
    
    public func setCenterAlignedItem(_ centerAlignedItem: ToolBarItemDataBuilder.ToolBarItemData) -> ToolBarItemsDataBuilder {
        self.centerAlignedItem = centerAlignedItem
        return self
    }
    
    public func setRightAlignedItem(_ rightAlignedItem: ToolBarItemDataBuilder.ToolBarItemData) -> ToolBarItemsDataBuilder {
        self.rightAlignedItem = rightAlignedItem
        return self
    }
    
    public func setRightAlignedSecondItem(_ rightAlignedSecondItem: ToolBarItemDataBuilder.ToolBarItemData) -> ToolBarItemsDataBuilder {
        self.rightAlignedSecondItem = rightAlignedSecondItem
        return self
    }
    
    /// Spacing between the text and image
    public func setRightAlignedThirdItem(_ rightAlignedThirdItem: ToolBarItemDataBuilder.ToolBarItemData) -> ToolBarItemsDataBuilder {
        self.rightAlignedThirdItem = rightAlignedThirdItem
        return self
    }
    
    public func build() -> ToolBarItemsData {
        ToolBarItemsData(leftAlignedItem: leftAlignedItem,
                         leftAlignedSecondItem: leftAlignedSecondItem,
                         centerAlignedItem: centerAlignedItem,
                         rightAlignedItem: rightAlignedItem,
                         rightAlignedSecondItem: rightAlignedSecondItem,
                         rightAlignedThirdItem: rightAlignedThirdItem)
    }
}

public class ToolBarItemDataBuilder {
    public struct ToolBarItemData {
        let image: Image?
        let titleString: String
        let tintColor: Color?
        let titleFont: Font
        let callback: (() -> Void)?
        let accessibilityIdentifier: String
    }
    
    // MARK: - Private properties
    
    private(set) var titleString: String = ""
    private(set) var titleFont: Font = Theme.current.subtitle2.font
    private(set) var accessibilityIdentifier: String = ""
    
    private(set) var callback: (() -> Void)? = nil
    private(set) var image: Image? = nil
    private(set) var tintColor: Color?
    
    public init() {}
    
    // MARK: - Public functions
    
    /// add  a tappable icon in navigationBar eg. profile, home
    public func setImage(_ image: Image) -> ToolBarItemDataBuilder {
        self.image = image
        return self
    }
    
    /// add  a title in navigationBar eg. profile, home
    public func setTitleString(_ titleString: String) -> ToolBarItemDataBuilder {
        self.titleString = titleString
        return self
    }
    
    /// tintColor changes the color of Image, title added to navBar. Default value is White for now.
    public func setTintColor(_ tintColor: Color) -> ToolBarItemDataBuilder {
        self.tintColor = tintColor
        return self
    }
    
    /// Default value is Theme.current.subtitle2.font
    public func setTitleFont(_ titleFont: Font) -> ToolBarItemDataBuilder {
        self.titleFont = titleFont
        return self
    }
    
    /// get a callback once user taps on the icon.
    public func setCallback(_ callback: @escaping (() -> Void)) -> ToolBarItemDataBuilder {
        self.callback = callback
        return self
    }
    
    public func setAccessibilityIdentifier(_ accessibilityIdentifier: String) -> ToolBarItemDataBuilder {
        self.accessibilityIdentifier = accessibilityIdentifier
        return self
    }
    
    public func build() -> ToolBarItemData {
        ToolBarItemData(image: image,
                        titleString: titleString,
                        tintColor: tintColor,
                        titleFont: titleFont,
                        callback: callback,
                        accessibilityIdentifier: accessibilityIdentifier)
    }
}
