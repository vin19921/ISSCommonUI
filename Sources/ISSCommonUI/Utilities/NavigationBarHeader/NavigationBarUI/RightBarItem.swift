//
//  RightBarItem.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import Foundation
import UIKit

final class RightBarItem: UIView, NibLoadableCUI {
    @IBOutlet private var primaryButton: UIButton!
    @IBOutlet private var secondaryButton: UIButton!
    @IBOutlet private var tertiaryButton: UIButton!
    private var bgColor: UIColor = .clear

    var trailingItems: TrailingItems? {
        didSet {
            setPropertiesforElements()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(needSafeAreaInset: false)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib(needSafeAreaInset: false)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if backgroundColor != .clear {
            layer.cornerRadius = bounds.size.height * 0.5
            layer.masksToBounds = true
        }
    }
    
    func updateBackgroundColor(bgColor: UIColor) {
        self.bgColor = bgColor
    }

    private func setPropertiesforElements() {
        updateViewConstraints()
        primaryButton.setTitle("", for: .normal)
        secondaryButton.setTitle("", for: .normal)
        tertiaryButton.setTitle("", for: .normal)
        if let tertiaryAction = trailingItems?.tertiaryAction {
            tertiaryButton.setImage(tertiaryAction.image?.applyTintCUI(tintColor: tertiaryAction.tintColor), for: .normal)
            tertiaryButton.contentHorizontalAlignment = .leading
            tertiaryButton.accessibilityLabel = tertiaryAction.accessibilityId
        } else {
            tertiaryButton.isHidden = true
        }

        if let primaryAction = trailingItems?.primaryAction {
            primaryButton.setImage(primaryAction.image?.applyTintCUI(tintColor: primaryAction.tintColor), for: .normal)
            primaryButton.contentHorizontalAlignment = .trailing
            primaryButton.accessibilityLabel = primaryAction.accessibilityId
        } else {
            primaryButton.isHidden = true
        }

        if let secondaryAction = trailingItems?.secondaryAction {
            secondaryButton.setImage(secondaryAction.image?.applyTintCUI(tintColor: secondaryAction.tintColor), for: .normal)
            secondaryButton.contentHorizontalAlignment = .center
            secondaryButton.accessibilityLabel = secondaryAction.accessibilityId
        } else {
            secondaryButton.isHidden = true
        }

        backgroundColor = bgColor
        if backgroundColor != .clear {
            primaryButton.contentHorizontalAlignment = .center
            secondaryButton.contentHorizontalAlignment = .center
            tertiaryButton.contentHorizontalAlignment = .center
        }
    }

    private func updateViewConstraints() {
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.widthAnchor.constraint(equalToConstant: ButtonSize.width).isActive = true
        primaryButton.heightAnchor.constraint(equalToConstant: ButtonSize.height).isActive = true
        secondaryButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryButton.widthAnchor.constraint(equalToConstant: ButtonSize.width).isActive = true
        secondaryButton.heightAnchor.constraint(equalToConstant: ButtonSize.height).isActive = true
        tertiaryButton.translatesAutoresizingMaskIntoConstraints = false
        tertiaryButton.widthAnchor.constraint(equalToConstant: ButtonSize.width).isActive = true
        tertiaryButton.heightAnchor.constraint(equalToConstant: ButtonSize.height).isActive = true
    }

    @IBAction private func tertiaryButtonAction(_: Any) {
        trailingItems?.tertiaryAction?.callback?()
    }

    @IBAction private func centerButtonAction(_: Any) {
        trailingItems?.secondaryAction?.callback?()
    }

    @IBAction private func primaryButtonAction(_: Any) {
        trailingItems?.primaryAction?.callback?()
    }
}
