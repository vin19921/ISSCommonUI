//
//  ISSCommonUIGateway.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import UIKit

public protocol ImageLoaderCUI: RawRepresentable where RawValue == String {
    var image: UIImage { get }
    var templateImage: UIImage? { get }
    var originalImage: UIImage? { get }
}

public extension ImageLoaderCUI {
    var image: UIImage {
        return UIImage(named: rawValue,
                       in: .resource,
                       with: .none) ?? UIImage()
    }

    var templateImage: UIImage? {
        return UIImage(named: rawValue,
                       in: .resource,
                       with: .none)?
            .withRenderingMode(.alwaysTemplate)
    }

    var originalImage: UIImage? {
        return UIImage(named: rawValue,
                       in: .resource,
                       with: .none)?
            .withRenderingMode(.alwaysOriginal)
    }
}
