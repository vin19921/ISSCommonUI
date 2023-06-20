//
//  UIView+Extension.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

import ISSTheme
import UIKit

// MARK: - NSLayout extension.

public extension UIView {
    /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    /// - Parameters:
    ///   - superView: parent view
    ///   - insets: UIEdgeInsets if required, default is .zero
    ///   - heightConstant: height
    ///   - needSafeAreaInset: consider safeAreaLayoutGuide
    /// - Returns: returns ReturnTouple with leading, trailing, top etc ..
    @discardableResult func fixBoundsCUI(with superView: UIView,
                                         insets: UIEdgeInsets = .zero,
                                         heightConstant: CGFloat? = nil,
                                         needSafeAreaInset: Bool = true) -> LayoutConstraintCUI
    {
        let leading, trailing, top: NSLayoutConstraint
        var bottom: NSLayoutConstraint?
        var height: NSLayoutConstraint?
        if needSafeAreaInset {
            leading = safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor,
                                                                   constant: insets.left)
            let trailingAnchor = safeAreaLayoutGuide.trailingAnchor
            trailing = superView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                               constant: insets.right)
            top = safeAreaLayoutGuide.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor,
                                                           constant: insets.top)
            if let heightConstant = heightConstant {
                height = safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: heightConstant)
            } else {
                let bottomAnchor = safeAreaLayoutGuide.bottomAnchor
                bottom = superView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                               constant: insets.bottom)
            }
        } else {
            leading = leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left)
            trailing = superView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
            top = topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top)
            if let heightConstant = heightConstant {
                height = heightAnchor.constraint(equalToConstant: heightConstant)
            } else {
                bottom = superView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
            }
        }
        let layoutConstraint = LayoutConstraintCUI(leadingConstraint: leading,
                                                trailingConstraint: trailing,
                                                topConstraint: top,
                                                bottomConstraint: bottom,
                                                heightConstraint: height)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leading, trailing, top])
        guard let constraint = height ?? bottom else { return layoutConstraint }
        NSLayoutConstraint.activate([constraint])
        return layoutConstraint
    }
    
    /// Dynamic size for tableview header/footer
    /// - Returns: modified height
    @discardableResult func viewSizeToFitCUI() -> UIView {
        let size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        guard frame.size.height != size.height else { return self }
        
        frame.size.height = size.height
        return self
    }
    
    /// Generic function for loading nib
    /// - Returns: loaded class
    class func fromNibCUI<T: UIView>() -> T? {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T
    }
    
    /// To add rounded corners to view
    /// - Parameters:
    ///     - corners: Array of Corners, ex: [.bottomLeft, .bottomRight, .topRight, .topLeft]
    ///     - radius: Radius for rounded corner
    func roundCornersCUI(for corners: UIRectCorner = .allCorners, radius: CGFloat = 10) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// Returns the ultimate parent view
    var parentViewCUI: UIView? {
        var parentView: UIView?
        var view: UIView? = self
        
        while view != nil {
            if let superView = view?.superview {
                parentView = superview
                view = superView
            } else {
                view = nil
            }
        }
        
        return parentView
    }
}

public extension UIView {
/// This is the function to convert UIView to UIImage
    func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
