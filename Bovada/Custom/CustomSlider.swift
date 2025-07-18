//
//  CustomSlider.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 13.07.2025.
//
import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double> = 0...5

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let totalSteps = Double(range.upperBound - range.lowerBound)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.white)
                    .frame(height: 8)
                Capsule()
                    .fill(.redMain)
                    .frame(width: CGFloat(Double(value - range.lowerBound) / totalSteps) * width, height: 8)
                Circle()
                    .fill(.redMain)
                    .frame(width: 18, height: 18)
                    .offset(x: CGFloat(Double(value - range.lowerBound) / totalSteps) * width - 9)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let percent = min(max(0, gesture.location.x / width), 1)
                                let newValue = (percent * totalSteps).rounded() + range.lowerBound
                                value = min(max(range.lowerBound, newValue), range.upperBound)
                            }
                    )
            }
        }
        .frame(height: 40)
    }
}


struct CustomSliderPreview: View {
    @State private var sliderValue: Double = 800

    var body: some View {
        CustomSlider(value: $sliderValue, range: 800...1500)
            .padding()
            .background(.black)
    }
}

#Preview {
    CustomSliderPreview()
}
