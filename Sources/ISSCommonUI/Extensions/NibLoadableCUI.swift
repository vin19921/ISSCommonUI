//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

import UIKit

protocol NibLoadableCUI: AnyObject {
    func loadFromNib(needSafeAreaInset: Bool)
}

extension NibLoadableCUI where Self: UIView {
    func loadFromNib(needSafeAreaInset: Bool = true) {
        guard let view = viewFromNibForClass() else { return }

        addSubview(view)
        view.fixBoundsCUI(with: self, needSafeAreaInset: needSafeAreaInset)
    }

    func viewFromNibForClass() -> UIView? {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: .resource)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
