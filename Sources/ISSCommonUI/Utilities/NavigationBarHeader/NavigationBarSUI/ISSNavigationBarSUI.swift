//
//  ISSNavigationBarSUI.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import ISSTheme
import SwiftUI

/// ISSNavigationBarSUI is custom navigation bar header component to be used across creators app.
///
/// An example usage from SwiftUI:
///
/// Example1:
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
///     ISSNavigationBarSUI(data: issNavBarBuilder)
///
/// Example2:
/// is of use of Transparent NavigationBar where content starts from top of screen eg. Event Details , Program Details
///
///     let imageItem = ToolBarItemDataBuilder()
///     .setImage(Image("backIcon"))
///     .build()
///     let textItem = ToolBarItemDataBuilder()
///     .setTitleString("test Title")
///     .build()
///
///     let toolBarItems = ToolBarItemsDataBuilder()
///     .setLeftAlignedItem(imageItem)
///     .setRightAlignedItem(imageItem)
///     .setRightAlignedSecondItem(imageItem)
///     .setRightAlignedThirdItem(imageItem)
///     .build()
///
///     let issNavBarBuilder = ISSNavigationBarBuilder()
///     .setToolBarItems(toolBarItems)
///     .transparentNavigationBar()
///     .setTintColor(.black)
///     .setNavigationBarHeightOffsetBasedOnStatusBar(true)
///     .build()
///     ZStack(alignment: .top) {
///         ISSNavigationBarSUI(data: issNavBarBuilder).zIndex(1)
///         // instead of  ScrollView we can add any View:
///         ScrollView {
///             Image("bricks")
///             .resizable()
///             .edgesIgnoringSafeArea(.all)
///             .scaledToFill()
///         }
///     } .edgesIgnoringSafeArea(.top)
public struct ISSNavigationBarSUI: View {
    private var toolBarItems: ToolBarItemsDataBuilder.ToolBarItemsData?
    private var height: CGFloat?
    private var backgroundColor: Color?
    private var tintColor: Color?
    private var foregroundColor: Color?
    private var imageBackgroundColor: Color?
    private var navigationBarHeightOffset: CGFloat?
    private var isNavigationBarHeightOffsetBasedOnStatusBar: Bool = false
    private var roundedbuttonSize: CGFloat = 36
    private var includeStatusBarArea = false
    
    private var isLeftAlignedItemsVisible: Bool {
        toolBarItems?.leftAlignedSecondItem != nil || toolBarItems?.leftAlignedItem != nil
    }
    private var isCenterAlignedItemsVisible: Bool {
        toolBarItems?.centerAlignedItem != nil
    }
    private var isRightAlignedItemsVisible: Bool {
        toolBarItems?.rightAlignedItem != nil || toolBarItems?.rightAlignedSecondItem != nil || toolBarItems?.rightAlignedThirdItem != nil
    }
    
    private var xOffset: CGFloat {
        /// All iPhone devices which are of pro max or  plus category require more offset
        /// to showcase the padding value of 16.0
        let shouldChangeOffset = UIScreen.main.bounds.width >= 414
        return shouldChangeOffset ? 20.0: 16.0
    }
    
    private var statusBarHeight: CGFloat {
        let window = UIApplication.shared.connectedScenes
            .map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter({ $0.isKeyWindow }).first
        
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    public init(data: ISSNavigationBarBuilder.ISSNavigationBarData)
    {
        self.toolBarItems = data.toolBarItems
        self.height = data.height
        self.backgroundColor = data.backgroundColor
        self.tintColor = data.tintColor
        self.foregroundColor = data.foregroundColor
        self.imageBackgroundColor = data.imageBackgroundColor
        self.navigationBarHeightOffset = data.navigationBarHeightOffset
        self.isNavigationBarHeightOffsetBasedOnStatusBar = data.isNavigationBarHeightOffsetBasedOnStatusBar
        self.roundedbuttonSize = data.roundedbuttonSize
        self.includeStatusBarArea = data.includeStatusBarArea
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if includeStatusBarArea {
                (backgroundColor ?? .clear).frame(height: statusBarHeight)
            }
            HStack(spacing: 0) {
                if isLeftAlignedItemsVisible {
                    HStack(spacing: 0) {
                        if let leftAlignedItem = toolBarItems?.leftAlignedItem {
                            ToolBarItemView(toolBarItem: leftAlignedItem,
                                            tintColor: tintColor,
                                            foregroundColor: foregroundColor,
                                            height: height,
                                            imageBackgroundColor: imageBackgroundColor,
                                            roundedbuttonSize: roundedbuttonSize,
                                            imageAlignment: .leading)
                        }
                        
                        if let leftAlignedSecondItem = toolBarItems?.leftAlignedSecondItem {
                            ToolBarItemView(toolBarItem: leftAlignedSecondItem,
                                            tintColor: tintColor,
                                            foregroundColor: foregroundColor,
                                            height: height,
                                            imageBackgroundColor: imageBackgroundColor,
                                            roundedbuttonSize: roundedbuttonSize)
                        }
                    } .frame(maxWidth: .infinity, alignment: .leading)
                }
                if isCenterAlignedItemsVisible {
                    HStack(spacing: 0) {
                        if let centerAlignedItem = toolBarItems?.centerAlignedItem {
                            ToolBarItemView(toolBarItem: centerAlignedItem,
                                            tintColor: tintColor,
                                            foregroundColor: foregroundColor,
                                            height: height,
                                            imageBackgroundColor: imageBackgroundColor,
                                            roundedbuttonSize: roundedbuttonSize)
                        }
                    } .frame(maxWidth: .infinity, alignment: .center)
                }
                
                ToolBarRightAlignedItems(toolBarItems: toolBarItems,
                                         tintColor: tintColor,
                                         foregroundColor: foregroundColor,
                                         height: height,
                                         imageBackgroundColor: imageBackgroundColor,
                                         roundedbuttonSize: roundedbuttonSize)
                .frame(maxWidth: .infinity,alignment: .trailing)
            }
            .padding(EdgeInsets(top: 0,
                                leading: xOffset,
                                bottom: 0,
                                trailing: xOffset))
            .background(backgroundColor ?? .clear)
                .frame(height: height ?? 44)
                .ifCUI(navigationBarHeightOffset != nil || isNavigationBarHeightOffsetBasedOnStatusBar) { view in
                    view.offset(CGSize(width: 0, height: navigationBarHeightOffset ?? statusBarHeight))
                }
        }
    }
}

private struct ToolBarItemView: View {
    var toolBarItem: ToolBarItemDataBuilder.ToolBarItemData?
    var tintColor: Color?
    var foregroundColor: Color?
    var height: CGFloat?
    var imageBackgroundColor: Color?
    var roundedbuttonSize: CGFloat
    var imageAlignment: Alignment?
    
    private var statusBarHeight: CGFloat {
        let window = UIApplication.shared.connectedScenes
            .map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter({ $0.isKeyWindow }).first
        
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    fileprivate var body: some View {
        HStack(spacing: 0) {
            if (toolBarItem?.image == nil) {
                ToolBarWithText(toolBarItem: toolBarItem,
                                tintColor: tintColor,
                                foregroundColor: foregroundColor,
                                roundedbuttonSize: roundedbuttonSize)
                .fixedSize(horizontal: true, vertical: true)
            }
            else if (toolBarItem?.textFieldPlaceHolder == nil) {
                ToolBarWithTextField(roundedbuttonSize: roundedbuttonSize,
                                     textFieldPlaceholder: toolBarItem?.textFieldPlaceHolder ?? "",
                                     text: toolBarItem?.textFieldString ?? Binding<String>.constant(""))
                .fixedSize(horizontal: false, vertical: true)
            }
            else {
                ToolBarButtonWithImage(toolBarItem: toolBarItem,
                                       tintColor: tintColor,
                                       foregroundColor: foregroundColor,
                                       imageBackgroundColor: imageBackgroundColor,
                                       roundedbuttonSize: roundedbuttonSize,
                                       imageAlignment: imageAlignment)
            }
        }.accessibilityIdentifier(toolBarItem?.accessibilityIdentifier ?? "")
            .frame(height: height ?? 44)
            .allowsHitTesting(toolBarItem?.image != nil)
//            .foregroundColor(foregroundColor)
    }
}

private struct ToolBarWithText: View {
    var toolBarItem: ToolBarItemDataBuilder.ToolBarItemData?
    var tintColor: Color?
    var foregroundColor: Color?
    var roundedbuttonSize: CGFloat
    
    fileprivate var body: some View {
        Text(toolBarItem?.titleString ?? "")
            .font(toolBarItem?.titleFont ?? Theme.current.subtitle2.font)
            .foregroundColor(toolBarItem?.tintColor ?? tintColor)
            .lineLimit(1)
            .frame(height: roundedbuttonSize)
            .accessibilityValue(toolBarItem?.titleString ?? "")
    }
}

private struct ToolBarButtonWithImage: View {
    var toolBarItem: ToolBarItemDataBuilder.ToolBarItemData?
    var tintColor: Color?
    var foregroundColor: Color?
    var imageBackgroundColor: Color?
    var roundedbuttonSize: CGFloat
    var imageAlignment: Alignment?
    
    fileprivate var body: some View {
        Button {
            toolBarItem?.callback?()
        } label: {
            toolBarItem?.image?
                .ifCUI((toolBarItem?.tintColor ?? tintColor) != nil) { view in
                    view.colorMultiply(toolBarItem?.tintColor ?? tintColor ?? .clear)
                }
                .aspectRatio(contentMode: .fit)
        }
        .ifCUI(imageBackgroundColor == nil) { view in
            view.frame(width: roundedbuttonSize,
                       height: roundedbuttonSize,
                       alignment: imageAlignment ?? .center)
        }
        .ifCUI(imageBackgroundColor != nil) { view in
            view.frame(width: roundedbuttonSize,
                       height: roundedbuttonSize)
            .background(imageBackgroundColor ?? .clear)
                .clipShape(Circle())
        }
        .ifCUI(foregroundColor != nil) { view in
            view.foregroundColor(foregroundColor)
        }
    }
}

private struct ToolBarWithTextField: View {
    var toolBarItem: ToolBarItemDataBuilder.ToolBarItemData?
    var tintColor: Color?
    var foregroundColor: Color?
    var roundedbuttonSize: CGFloat
    var textFieldPlaceholder: String?
    @Binding var text: String

    fileprivate var body: some View {
        TextField(toolBarItem?.textFieldPlaceHolder ?? "", text: $text)
            .font(toolBarItem?.titleFont ?? Theme.current.subtitle2.font)
            .foregroundColor(toolBarItem?.tintColor ?? tintColor)
            .lineLimit(1)
            .frame(height: roundedbuttonSize)
//            .accessibilityValue(toolBarItem?.titleString ?? "")
    }
}

private struct ToolBarRightAlignedItems: View {
    var toolBarItems: ToolBarItemsDataBuilder.ToolBarItemsData?
    var tintColor: Color?
    var foregroundColor: Color?
    var height: CGFloat?
    var imageBackgroundColor: Color?
    var roundedbuttonSize: CGFloat
    
    fileprivate var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                if let rightAlignedThirdItem = toolBarItems?.rightAlignedThirdItem {
                    ToolBarItemView(toolBarItem: rightAlignedThirdItem,
                                    tintColor: tintColor,
                                    foregroundColor: foregroundColor,
                                    height: height,
                                    imageBackgroundColor: imageBackgroundColor,
                                    roundedbuttonSize: roundedbuttonSize,
                                    imageAlignment: .leading)
                }
                if let rightAlignedSecondItem = toolBarItems?.rightAlignedSecondItem {
                    ToolBarItemView(toolBarItem: rightAlignedSecondItem,
                                    tintColor: tintColor,
                                    foregroundColor: foregroundColor,
                                    height: height,
                                    imageBackgroundColor: imageBackgroundColor,
                                    roundedbuttonSize: roundedbuttonSize,
                                    imageAlignment: .center)
                }
                if let rightAlignedItem = toolBarItems?.rightAlignedItem {
                    ToolBarItemView(toolBarItem: rightAlignedItem,
                                    tintColor: tintColor,
                                    foregroundColor: foregroundColor,
                                    height: height,
                                    imageBackgroundColor: imageBackgroundColor,
                                    roundedbuttonSize: roundedbuttonSize,
                                    imageAlignment: .trailing)
                }
            }
            .ifCUI(imageBackgroundColor != nil) { view in
                view
                    .background(imageBackgroundColor ?? .clear)
                    .frame(height: roundedbuttonSize)
                    .cornerRadius(roundedbuttonSize/2)
            }
        }
    }
}
