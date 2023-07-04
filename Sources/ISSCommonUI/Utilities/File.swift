//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 04/07/2023.
//

import SwiftUI

public struct FontWithLineHeightCUI: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat
    let verticalPadding: CGFloat

    public func body(content: Content) -> some View {
        content
            .font(Font(font as CTFont))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, ((lineHeight - font.lineHeight) / 2) + verticalPadding)
    }
}
