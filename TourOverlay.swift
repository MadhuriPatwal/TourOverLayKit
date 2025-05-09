import SwiftUI

public struct TourOverlay: View {
    public let steps: [TourStep]
    public var onFinish: (() -> Void)? = nil

    @State private var currentStepIndex = 0
    @State private var screenSize: CGSize = .zero

    public init(steps: [TourStep], onFinish: (() -> Void)? = nil) {
        self.steps = steps
        self.onFinish = onFinish
    }

    public var body: some View {
        if !steps.isEmpty {
            GeometryReader { geo in
                let holeRect = steps[currentStepIndex].frame
                let tooltipWidth: CGFloat = 220
                let padding: CGFloat = 16

                // Dynamic X placement
                let placeRight = holeRect.maxX + tooltipWidth + padding < geo.size.width
                let tooltipX = placeRight
                    ? min(holeRect.maxX + tooltipWidth / 2 + padding, geo.size.width - tooltipWidth / 2 - padding)
                    : max(holeRect.minX - tooltipWidth / 2 - padding, tooltipWidth / 2 + padding)

                // Dynamic Y placement
                let tooltipY = min(max(holeRect.midY, tooltipWidth / 2), geo.size.height - tooltipWidth / 2)

                ZStack {
                    // Mask with transparent hole
                    Color.black.opacity(0.6)
                        .mask(
                            HoleShape(hole: holeRect, screenSize: geo.size)
                                .fill(style: FillStyle(eoFill: true))
                        )
                        .animation(.easeInOut(duration: 0.4), value: holeRect)
                        .onAppear {
                            screenSize = geo.size
                        }
                        .edgesIgnoringSafeArea(.all)

                    // Tooltip
                    VStack(alignment: .leading, spacing: 12) {
                        Text(steps[currentStepIndex].message)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)

                        Button(currentStepIndex == steps.count - 1 ? "Finish" : "Next") {
                            withAnimation {
                                if currentStepIndex < steps.count - 1 {
                                    currentStepIndex += 1
                                } else {
                                    onFinish?()
                                }
                            }
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .frame(width: tooltipWidth)
                    .background(Color.clear)
                    .position(x: tooltipX, y: tooltipY)
                }
            }
        }
    }
}

