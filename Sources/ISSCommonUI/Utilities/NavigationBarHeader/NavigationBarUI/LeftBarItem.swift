//
//  LeftBarItem.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import Foundation
import UIKit

final class LeftBarItem: UIView, NibLoadableCUI {
    @IBOutlet private var backBtn: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var widthConstraintOfBtn: NSLayoutConstraint!
    private var bgColor: UIColor = .clear

    var leadingItems: LeadingItems? {
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
        backBtn.setTitle("", for: .normal)
        if let backBtn = leadingItems?.action {
            self.backBtn.setImage(backBtn.image?.applyTintCUI(tintColor: backBtn.tintColor), for: .normal)
            widthConstraintOfBtn.constant = ButtonSize.width
            self.backBtn.accessibilityLabel = backBtn.accessibilityId
        } else {
            widthConstraintOfBtn.constant = 0
        }

        if let titleInfo = leadingItems?.title {
            titleLabel.text = titleInfo.title
            titleLabel.textColor = titleInfo.color
            titleLabel.font = titleInfo.font
            titleLabel.accessibilityLabel = titleInfo.accessibilityId
            titleLabel.accessibilityValue = titleInfo.title
        } else {
            titleLabel.isHidden = true
        }
        updateViewConstraints()
        backgroundColor = bgColor
        if backgroundColor == .clear, leadingItems?.action != nil  {
            backBtn.contentHorizontalAlignment = .leading
        } else {
            backBtn.contentHorizontalAlignment = .center
        }
    }

    private func updateViewConstraints() {
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.widthAnchor.constraint(equalToConstant: ButtonSize.width).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: ButtonSize.height).isActive = true
    }

    @IBAction private func backBtnAction(_: Any) {
        leadingItems?.action?.callback?()
    }
}
