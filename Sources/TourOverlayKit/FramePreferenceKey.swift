//
//  FramePreferenceKey.swift
//  AppTourDemo
//
//  Created by Bandish Dave on 08/05/25.
//

import SwiftUI

// MARK: - Frame Preference Key
public struct FramePreferenceKey: PreferenceKey {
    public static var defaultValue: [String: CGRect] = [:]
    public static func reduce(value: inout [String: CGRect], nextValue: () -> [String: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
