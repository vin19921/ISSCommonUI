//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 11/07/2023.
//

import SwiftUI
import UIKit

extension UIFont {
    /// Returns SwiftUI version of the font
    var suiFont: Font {
        Font(self as CTFont)
    }
}
