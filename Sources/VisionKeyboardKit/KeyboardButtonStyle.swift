//
// Copyright © 2023 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

struct KeyboardButtonStyle: PrimitiveButtonStyle {
    let isDark: Bool
    let isToggled: Bool
    let fontSize: CGFloat
    let width: CGFloat
    let height: CGFloat
    let onTouchDown: () -> Void
    let onTouchUp: () -> Void

    @State private var isPressed: Bool = false

    private func dragGesture(configuration: Configuration) -> some Gesture {
        DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        if !isPressed {
                            isPressed = true
                            onTouchDown()
                        }
                    })
                    .onEnded { _ in
                        isPressed = false
                        onTouchUp()
                        configuration.trigger()
                    }
    }

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if isToggled {
                Capsule()
                    .frame(width: width, height: height)
                    .foregroundStyle(.white)
                    .background(in: Capsule())
                    .backgroundStyle(.shadow(.drop(radius: 2, x: 2, y: 2)))
            } else if isDark {
                Capsule()
                    .frame(width: width, height: height)
                    .foregroundStyle(.thickMaterial.shadow(.inner(radius: 1, x: -1, y: -1)))
                    .background(in: Capsule())
                    .backgroundStyle(.shadow(.drop(radius: 2, x: 2, y: 2)))
            } else {
                Capsule()
                    .frame(width: width, height: height)
                    .foregroundStyle(.shadow(.inner(radius: 1, x: -1, y: -1)).tertiary)
                    .background(in: Capsule())
                    .backgroundStyle(.shadow(.drop(radius: 2, x: 2, y: 2)))
            }
            if isPressed {
                Capsule()
                    .frame(width: width+8, height: height+8)
                    .foregroundStyle(.white.opacity(0.25))
            }
            configuration.label
                .font(.system(size: fontSize))
                .foregroundStyle(isToggled ? .black : .white)
        }
        .frame(width: width + 4, height: height + 4)
        .hoverEffect()
        .frame(depth: isPressed ? 0 : 12)
        .gesture(dragGesture(configuration: configuration))
    }
}

extension PrimitiveButtonStyle where Self == KeyboardButtonStyle {
    static func keyboardButton(isDark: Bool = false, isToggled: Bool = false, fontSize: CGFloat = 24, width: CGFloat = 50, height: CGFloat = 50, onTouchDown: @escaping () -> Void = {}, onTouchUp: @escaping () -> Void = {}) -> KeyboardButtonStyle {
        KeyboardButtonStyle(isDark: isDark, isToggled: isToggled, fontSize: fontSize, width: width, height: height, onTouchDown: onTouchDown, onTouchUp: onTouchUp)
    }
}
