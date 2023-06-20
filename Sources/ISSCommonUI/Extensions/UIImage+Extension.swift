//
//  UIImage+Extension.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

import UIKit

public extension UIImage {
    func applyTintCUI(tintColor: UIColor?) -> UIImage {
        if let tint = tintColor {
            return withTintColor(tint, renderingMode: .alwaysOriginal)
        } else {
            return withRenderingMode(.alwaysOriginal)
        }
    }

    static func loadImage(named: String, for traitCollection: UITraitCollection? = nil) -> UIImage? {
        UIImage(named: named, in: .module, compatibleWith: traitCollection)
    }

    /// Method to resize an image to a new height, while maintaining it's aspect ratio.
    func aspectFittedToHeight(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
