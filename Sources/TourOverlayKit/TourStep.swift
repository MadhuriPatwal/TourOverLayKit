//
//  TourStep.swift
//  AppTourDemo
//
//  Created by Bandish Dave on 08/05/25.
//

import SwiftUI

public struct TourStep: Identifiable {
    public let id = UUID()
    public let frame: CGRect
    public let message: String

    public init(frame: CGRect, message: String) {
        self.frame = frame
        self.message = message
    }
}
