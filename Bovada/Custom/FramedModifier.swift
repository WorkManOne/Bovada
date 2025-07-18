//
//  GrayFrameBackground.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 24.06.2025.
//

import SwiftUI

extension View {
    func darkFramed(isBordered: Bool = false) -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity)
            .background(.darkFrame)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.redMain, lineWidth: isBordered ? 1 : 0)
            }
    }
    func colorFramed(color: Color) -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .darkFramed()

}

//
//struct GrayFrameBackground: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(.grayAccent)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//    }
//}

