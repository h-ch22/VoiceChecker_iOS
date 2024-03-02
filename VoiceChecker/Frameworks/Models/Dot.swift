//
//  Dot.swift
//  VoiceChecker
//
//  Created by Changjin Ha on 3/3/24.
//

import SwiftUI

struct Dot: View {
    var width: CGFloat = 8
    var y: CGFloat
    
    var body: some View {
        Circle()
            .frame(width: width, height: width, alignment: .center)
            .opacity(y == 0 ? 0.1 : 1)
            .offset(y: y)
            .foregroundColor(.gray)
    }
}
