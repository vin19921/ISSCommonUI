//
//  ISSCommonUIGateway.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import SwiftUI

public protocol ImageLoaderSUICUI: RawRepresentable where RawValue == String {
    var bundle: Bundle? { get }
    var image: Image { get }
    var templateImage: Image? { get }
    var originalImage: Image? { get }
}

public extension ImageLoaderSUICUI {
    var image: Image {
        return Image(rawValue,
                     bundle: bundle ?? Bundle.resource)
    }

    var templateImage: Image? {
        return Image(rawValue,
                     bundle: bundle ?? Bundle.resource)
            .renderingMode(.template)
    }

    var originalImage: Image? {
        return Image(rawValue,
                     bundle: bundle ?? Bundle.resource)
            .renderingMode(.original)
    }
    
    var bundle: Bundle?  { return nil }
}
