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
import RealityKit

private let kDebounceTime: Duration = .milliseconds(25)

struct KeyboardButtonStyle: PrimitiveButtonStyle {
    let isDark: Bool
    let isToggled: Bool
    let fontSize: CGFloat
    let width: CGFloat
    let height: CGFloat
    let clickSound: KeyboardClickSound.File
    let onTouchDown: () -> Void
    let onTouchUp: () -> Void

    @State private var isPressed: Bool = false
    @State private var debounceTask: Task<Void, Never>?
    @Environment(KeyboardState.self) private var state

    private func spatialGesture(configuration: Configuration) -> some Gesture {
        SpatialEventGesture()
            .onChanged { events in
                for event in events {
                    switch event.kind {
                    case .indirectPinch, .pointer, .touch:
                        if !isPressed {
                            isPressed = true
                            onTouchDown()
                        }
                        // touch events require debouncing
                        if event.kind == .touch {
                            debounceTask?.cancel()
                            debounceTask = nil
                        }
                    default: break
                    }
                }
            }
            .onEnded { events in
                for event in events {
                    switch event.kind {
                    case .indirectPinch, .pointer:
                        isPressed = false
                        onTouchUp()
                        configuration.trigger()
                    case .touch:
                        // ignore any .ended phase followed immediately by an .active phase
                        let trigger = configuration.trigger
                        debounceTask = Task { @MainActor in
                            try? await Task.sleep(for: kDebounceTime)
                            if !Task.isCancelled {
                                isPressed = false
                                onTouchUp()
                                trigger()
                            }
                        }
                    default: break
                    }
                }
            }
    }

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if isPressed {
                // we only create the RealityView when the button is activated
                // this is where the click sound will orginate from
                RealityView { content in
                    content.add(state.clicker.entity)
                    Task {
                        state.clicker.play(sound: clickSound)
                    }
                }
            }
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
        .gesture(spatialGesture(configuration: configuration))
    }
}

extension PrimitiveButtonStyle where Self == KeyboardButtonStyle {
    static func keyboardButton(isDark: Bool = false, isToggled: Bool = false, fontSize: CGFloat = 24, width: CGFloat = 50, height: CGFloat = 50, clickSound: KeyboardClickSound.File = .normal, onTouchDown: @escaping () -> Void = {}, onTouchUp: @escaping () -> Void = {}) -> KeyboardButtonStyle {
        KeyboardButtonStyle(isDark: isDark, isToggled: isToggled, fontSize: fontSize, width: width, height: height, clickSound: clickSound, onTouchDown: onTouchDown, onTouchUp: onTouchUp)
    }
}
