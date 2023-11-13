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

struct KeyboardKeyView: View {
    let key: String
    var shift: String?
    let code: KeyboardKeyCode
    var width: CGFloat = 50
    var height: CGFloat = 50
    var isDark: Bool = false
    var isToggled: Bool = false
    var action: () -> Void = {}

    @Environment(KeyboardState.self) private var state

    private var isShifted: Bool {
        !state.modifier.isDisjoint(with: [.leftShift, .rightShift])
    }

    var body: some View {
        Button(action: action) {
            Text(isShifted ? shift ?? key : key)
        }.buttonStyle(.keyboardButton(isDark: isDark, isToggled: isToggled, fontSize: width > 50 && key.count > 1 ? 20 : key.count > 1 ? 16 : 24, width: width, height: height, onTouchDown: {
            state.keyDown(code)
        }, onTouchUp: {
            state.keyUp(code)
        }))
    }
}

struct KeyboardToggleKeyView: View {
    let key: String
    let code: KeyboardKeyCode
    let modifier: KeyboardModifier
    var otherModifier: KeyboardModifier?
    var width: CGFloat = 50
    var height: CGFloat = 50
    var isDark: Bool = false

    @Environment(KeyboardState.self) private var state

    private var isOn: Bool {
        if let otherModifier = otherModifier {
            return !state.modifier.isDisjoint(with: [modifier, otherModifier])
        } else {
            return state.modifier.contains(modifier)
        }
    }

    var body: some View {
        KeyboardKeyView(key: key, code: code, width: width, height: height, isDark: isDark, isToggled: isOn) {
            if isOn {
                state.modifier.remove(modifier)
                if let otherModifier = otherModifier {
                    state.modifier.remove(otherModifier)
                }
            } else {
                state.modifier.insert(modifier)
                if let otherModifier = otherModifier {
                    state.modifier.insert(otherModifier)
                }
            }
        }
    }
}

#Preview {
    VStack {
        KeyboardKeyView(key: "a", code: .keyA)
        KeyboardKeyView(key: "a", code: .keyA, isDark: true)
        KeyboardKeyView(key: "a", code: .keyA, isToggled: true)
        KeyboardKeyView(key: "abcd", code: .keySpace)
        KeyboardKeyView(key: "abcd", code: .keySpace, width: 100)
    }
}
