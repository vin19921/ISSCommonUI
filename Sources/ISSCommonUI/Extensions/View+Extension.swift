//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

import SwiftUI

public extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder public func `ifCUI`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }

    func addToolBarButtonCUI(placement: ToolbarItemPlacement = .navigationBarTrailing,
                          buttonAction: (() -> Void)? = nil,
                          image: UIImage? = nil,
                          accessibilityIdentifier: String? = nil) -> some View
    {
        toolbar {
            ToolbarItem(placement: placement) {
                Button {
                    buttonAction?()
                } label: {
                    Image(uiImage: image ?? UIImage())
                }.accessibilityIdentifier(accessibilityIdentifier ?? "")
            }
        }
    }

    /// Sets the text color for a navigation bar title.
    /// - Parameter color: Color the title should be
    ///
    /// Supports both regular and large titles.
    @available(iOS 14, *)
    func navigationBarTitleTextColorCUI(_ color: Color) -> some View {
        let uiColor = UIColor(color)

        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]

        return self
    }
}

public extension View {
  func onAppCameToForegroundCUI(perform action: @escaping () -> Void) -> some View {
    self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
       action()
    }
  }

  func onAppWentToBackgroundCUI(perform action: @escaping () -> Void) -> some View {
    self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
      action()
    }
  }
}

public extension View {
/// This function changes our View to UIView, then calls another function to convert the newly-made UIView to a UIImage.
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        guard let window = UIApplication.shared.windows.first else { return nil }
        window.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
/// here is the call to the function that converts UIView to UIImage: asUIImage()
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

public extension View {
    /// ViewModifier to set a given Font and a given Line Height to the View.
    /// The Vertical Padding parameter is also considered as the .padding modifier is used to set the Line Height.
    ///
    /// - Parameters:
    ///   - font: The font to be set.
    ///   - lineHeight: The line height to be set.
    ///   - verticalPadding: The vertical padding to be set.
    /// - Returns: The modified view.
    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat, verticalPadding: CGFloat) -> some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeightCUI(font: font,
                                                        lineHeight: lineHeight,
                                                        verticalPadding: verticalPadding))
    }

    func navigationBarColor(backgroundColor: UIColor, textColor: UIColor) -> some View {
        modifier(NavigationBarColorModifier(backgroundColor: backgroundColor, textColor: textColor))
    }

    func addToolBarButton(placement: ToolbarItemPlacement = .navigationBarTrailing,
                          buttonAction: (() -> Void)? = nil,
                          image: UIImage? = nil,
                          accessibilityIdentifier: String? = nil) -> some View
    {
        toolbar {
            ToolbarItem(placement: placement) {
                Button {
                    buttonAction?()
                } label: {
                    Image(uiImage: image ?? UIImage())
                }.accessibilityIdentifier(accessibilityIdentifier ?? "")
            }
        }
    }

    func addToolBarTextField(placement: ToolbarItemPlacement = .navigationBarTrailing,
                             accessibilityIdentifier: String? = nil) -> some View {
        toolbar {
            ToolbarItem(placement: placement) {
                Color.clear
                    .accessibilityIdentifier(accessibilityIdentifier ?? "")
            }
        }
    }
}
