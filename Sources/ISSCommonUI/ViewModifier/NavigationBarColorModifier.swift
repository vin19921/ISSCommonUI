//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 11/07/2023.
//

import SwiftUI

public struct NavigationBarColorModifier: ViewModifier {
    var backgroundColor: UIColor
    var textColor: UIColor

    public init(backgroundColor: UIColor, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        let coloredAppearance = UINavigationBar.appearance()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.tintColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: textColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.all)
                    Spacer()
                }
            }
        }
    }
}
