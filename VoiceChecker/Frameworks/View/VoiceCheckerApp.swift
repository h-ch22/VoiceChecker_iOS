//
//  VoiceCheckerApp.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/2/24.
//

import SwiftUI

@main
struct VoiceCheckerApp: App {
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
