//
//  ISSNavigationBarData.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import ISSTheme
import SwiftUI

/// ISSNavigationBarData is used to set appropriate properties to ISSNavigationBar
///
/// An example usage from ISSNavigationBarData:
///
///     import ISSCommonUI
///     
///     let imageItem = ToolBarItemDataBuilder()
///     .setImage(Image(systemName: "globe"))
///     .build()
///
///     let textItem = ToolBarItemDataBuilder()
///     .setTitleString("test Title")
///     .build()
///
///     let toolBarItems = ToolBarItemsDataBuilder()
///     .setLeftAlignedItem(imageItem)
///     .setCenterAlignedItem(textItem)
///     .build()
///
///     let issNavBarBuilder = ISSNavigationBarBuilder()
///     .setToolBarItems(toolBarItems)
///     .build()
public class ISSNavigationBarBuilder {
    public struct ISSNavigationBarData {
        let toolBarItems: ToolBarItemsDataBuilder.ToolBarItemsData
        let height: CGFloat
        let backgroundColor: Color?
        let tintColor: Color?
        let imageBackgroundColor: Color?
        let navigationBarHeightOffset: CGFloat?
        let isNavigationBarHeightOffsetBasedOnStatusBar: Bool
        let roundedbuttonSize: CGFloat
        let includeStatusBarArea: Bool
    }
    
    // MARK: - Private properties
    private(set) var toolBarItems: ToolBarItemsDataBuilder.ToolBarItemsData = ToolBarItemsDataBuilder().build()
    private(set) var height: CGFloat = 44
    
    private(set) var backgroundColor: Color?
    private(set) var tintColor: Color?
    private(set) var imageBackgroundColor: Color? = nil
    private(set) var navigationBarHeightOffset: CGFloat? = nil
    private(set) var isNavigationBarHeightOffsetBasedOnStatusBar: Bool = false
    private(set) var roundedbuttonSize: CGFloat = 36.0
    private(set) var includeStatusBarArea: Bool = false
    
    public init() {}
    
    // MARK: - Public functions
    
    /// add Tool Bar items like Text, tappable Items to your navigationBar
    public func setToolBarItems(_ toolBarItems:  ToolBarItemsDataBuilder.ToolBarItemsData) -> ISSNavigationBarBuilder {
        self.toolBarItems = toolBarItems
        return self
    }

    /// we can customize the height for NavigationBar, Default height is 44px
    public func setHeight(_ height: CGFloat) -> ISSNavigationBarBuilder {
        self.height = height
        return self
    }

    /// we can customize the BackgroundColor for NavigationBar, Default is red
    public func setBackgroundColor(_ backgroundColor: Color) -> ISSNavigationBarBuilder {
        self.backgroundColor = backgroundColor
        return self
    }

    /// tintColor changes the color of Image, title added to navBar. Default value is White for now.
    public func setTintColor(_ tintColor: Color) -> ISSNavigationBarBuilder {
        self.tintColor = tintColor
        return self
    }

    /// we can have icons in the navBar with circle shaped background around those.
    public func setImageBackgroundColor(_ imageBackgroundColor: Color) -> ISSNavigationBarBuilder {
        self.imageBackgroundColor = imageBackgroundColor
        return self
    }
    
    public func transparentNavigationBar() -> ISSNavigationBarBuilder {
        self.backgroundColor = .clear
        return self
    }
    
    /// Add this offset to show NavBar at desired height.
    public func setNavigationBarHeightOffset(_ navigationBarHeightOffset: CGFloat) -> ISSNavigationBarBuilder {
        self.navigationBarHeightOffset = navigationBarHeightOffset
        return self
    }
    
    /// set as true if we require NavigationBar to be visible after an offset of status bar area.
    public func setNavigationBarHeightOffsetBasedOnStatusBar(_ isNavigationBarHeightOffsetBasedOnStatusBar: Bool) -> ISSNavigationBarBuilder {
        self.isNavigationBarHeightOffsetBasedOnStatusBar = isNavigationBarHeightOffsetBasedOnStatusBar
        return self
    }
    
    public func setRoundedbuttonSize(_ roundedbuttonSize: CGFloat) -> ISSNavigationBarBuilder {
        self.roundedbuttonSize = roundedbuttonSize
        return self
    }
    
    public func includeStatusBarArea(_ includeStatusBarArea: Bool) -> ISSNavigationBarBuilder {
        self.includeStatusBarArea = includeStatusBarArea
        return self
    }
    
    public func build() -> ISSNavigationBarData {
        ISSNavigationBarData(toolBarItems: toolBarItems,
                               height: height,
                               backgroundColor: backgroundColor,
                               tintColor: tintColor,
                               imageBackgroundColor: imageBackgroundColor,
                               navigationBarHeightOffset: navigationBarHeightOffset,
                               isNavigationBarHeightOffsetBasedOnStatusBar: isNavigationBarHeightOffsetBasedOnStatusBar,
                               roundedbuttonSize: roundedbuttonSize,
                               includeStatusBarArea:  includeStatusBarArea)
    }
}
