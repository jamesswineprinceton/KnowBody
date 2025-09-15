//
//  BlueButtonModifier.swift
//  KnowBody
//
//  Created by James Swinehart on 7/30/25.
//

import SwiftUI

struct BlueButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 352, height: 44)
            .background(.blue)
            .cornerRadius(8)
    }
}
