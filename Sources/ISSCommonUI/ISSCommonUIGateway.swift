//
//  ISSCommonUIGateway.swift
//  ISS
//
//  Copyright © 2023 ISoftStone. All rights reserved.
//

import ISSTheme

/// The ISSCommonUIGateway facilitate initailizing package depdendencies such as theme
public enum ISSCommonUIGateway {
    /// - Parameters:
    ///     - theme:  refer to ISSTheme:
    public static func setTheme(_ theme: Theme) {
        Theme.current = theme
    }
 }
