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

struct KeyboardLayoutANSI: View {
    var body: some View {
        VStack {
            HStack {
                KeyboardKeyView(key: "⎋", code: .keyEscape, isDark: true)
                KeyboardKeyView(key: "F1", code: .keyF1)
                KeyboardKeyView(key: "F2", code: .keyF2)
                KeyboardKeyView(key: "F3", code: .keyF3)
                KeyboardKeyView(key: "F4", code: .keyF4)
                KeyboardKeyView(key: "F5", code: .keyF5)
                KeyboardKeyView(key: "F6", code: .keyF6)
                KeyboardKeyView(key: "F7", code: .keyF7)
                KeyboardKeyView(key: "F8", code: .keyF8)
                KeyboardKeyView(key: "F9", code: .keyF9)
                KeyboardKeyView(key: "F10", code: .keyF10)
                KeyboardKeyView(key: "F11", code: .keyF11)
                KeyboardKeyView(key: "F12", code: .keyF12)
            }
            HStack {
                KeyboardKeyView(key: "`", shift: "~", code: .keyGrave)
                KeyboardKeyView(key: "1", shift: "!", code: .key1)
                KeyboardKeyView(key: "2", shift: "@", code: .key2)
                KeyboardKeyView(key: "3", shift: "#", code: .key3)
                KeyboardKeyView(key: "4", shift: "$", code: .key4)
                KeyboardKeyView(key: "5", shift: "%", code: .key5)
                KeyboardKeyView(key: "6", shift: "^", code: .key6)
                KeyboardKeyView(key: "7", shift: "&", code: .key7)
                KeyboardKeyView(key: "8", shift: "*", code: .key8)
                KeyboardKeyView(key: "9", shift: "(", code: .key9)
                KeyboardKeyView(key: "0", shift: ")", code: .key0)
                KeyboardKeyView(key: "-", shift: "_", code: .keyMinus)
                KeyboardKeyView(key: "=", shift: "+", code: .keyEqual)
                KeyboardKeyView(key: "⌫", code: .keyBackspace, width: 65, isDark: true)
            }
            HStack {
                KeyboardKeyView(key: "⇥", code: .keyTab, width: 65, isDark: true)
                KeyboardKeyView(key: "q", shift: "Q", code: .keyQ)
                KeyboardKeyView(key: "w", shift: "W", code: .keyW)
                KeyboardKeyView(key: "e", shift: "E", code: .keyE)
                KeyboardKeyView(key: "r", shift: "R", code: .keyR)
                KeyboardKeyView(key: "t", shift: "T", code: .keyT)
                KeyboardKeyView(key: "y", shift: "Y", code: .keyY)
                KeyboardKeyView(key: "u", shift: "U", code: .keyU)
                KeyboardKeyView(key: "i", shift: "I", code: .keyI)
                KeyboardKeyView(key: "o", shift: "O", code: .keyO)
                KeyboardKeyView(key: "p", shift: "P", code: .keyP)
                KeyboardKeyView(key: "[", shift: "{", code: .keyLeftBracket)
                KeyboardKeyView(key: "]", shift: "}", code: .keyRightBracket)
                KeyboardKeyView(key: "\\", shift: "|", code: .keyBackslash)
            }
            HStack {
                KeyboardToggleKeyView(key: "⇪", code: .keyCapsLock, modifier: .capsLock, width: 65, isDark: true)
                KeyboardKeyView(key: "a", shift: "A", code: .keyA)
                KeyboardKeyView(key: "s", shift: "S", code: .keyS)
                KeyboardKeyView(key: "d", shift: "D", code: .keyD)
                KeyboardKeyView(key: "f", shift: "F", code: .keyF)
                KeyboardKeyView(key: "g", shift: "G", code: .keyG)
                KeyboardKeyView(key: "h", shift: "H", code: .keyH)
                KeyboardKeyView(key: "j", shift: "J", code: .keyJ)
                KeyboardKeyView(key: "k", shift: "K", code: .keyK)
                KeyboardKeyView(key: "l", shift: "L", code: .keyL)
                KeyboardKeyView(key: ";", shift: ":", code: .keySemicolon)
                KeyboardKeyView(key: "'", shift: "\"", code: .keyQuote)
                KeyboardKeyView(key: "return", code: .keyReturn, width: 85, isDark: true)
            }
            HStack {
                KeyboardToggleKeyView(key: "⇧", code: .keyShift, modifier: .leftShift, otherModifier: .rightShift, width: 85, isDark: true)
                KeyboardKeyView(key: "z", shift: "Z", code: .keyZ)
                KeyboardKeyView(key: "x", shift: "X", code: .keyX)
                KeyboardKeyView(key: "c", shift: "C", code: .keyC)
                KeyboardKeyView(key: "v", shift: "V", code: .keyV)
                KeyboardKeyView(key: "b", shift: "B", code: .keyB)
                KeyboardKeyView(key: "n", shift: "N", code: .keyN)
                KeyboardKeyView(key: "m", shift: "M", code: .keyM)
                KeyboardKeyView(key: ",", shift: "<", code: .keyComma)
                KeyboardKeyView(key: ".", shift: ">", code: .keyPeriod)
                KeyboardKeyView(key: "/", shift: "?", code: .keySlash)
                KeyboardToggleKeyView(key: "⇧", code: .keyRightShift, modifier: .rightShift, otherModifier: .leftShift, width: 85, isDark: true)
            }
            HStack {
                KeyboardToggleKeyView(key: "⌃", code: .keyControl, modifier: .leftControl, otherModifier: .rightControl, width: 65, isDark: true)
                KeyboardToggleKeyView(key: "⌥", code: .keyOption, modifier: .leftOption, otherModifier: .rightOption, width: 65, isDark: true)
                KeyboardToggleKeyView(key: "⌘", code: .keyCommand, modifier: .leftCommand, otherModifier: .rightCommand, width: 65, isDark: true)
                KeyboardKeyView(key: "space", code: .keySpace, width: 360)
                KeyboardToggleKeyView(key: "⌘", code: .keyRightCommand, modifier: .rightCommand, otherModifier: .leftCommand, width: 65, isDark: true)
                KeyboardToggleKeyView(key: "⌥", code: .keyRightOption, modifier: .rightOption, otherModifier: .leftOption, width: 65, isDark: true)
                KeyboardToggleKeyView(key: "⌃", code: .keyRightControl, modifier: .rightControl, otherModifier: .leftControl, width: 65, isDark: true)
            }
        }
    }

}

#Preview {
    KeyboardLayoutANSI()
}
