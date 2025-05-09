//
//  HoleShape.swift
//  AppTourDemo
//
//  Created by Bandish Dave on 08/05/25.
//

import SwiftUI

struct HoleShape: Shape {
    var hole: CGRect
    var screenSize: CGSize

    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)
        let roundedHole = RoundedRectangle(cornerRadius: 12)
            .path(in: hole)
        path.addPath(roundedHole)
        return path
    }

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(hole.minX, hole.minY) }
        set {
            hole.origin.x = newValue.first
            hole.origin.y = newValue.second
        }
    }
}
