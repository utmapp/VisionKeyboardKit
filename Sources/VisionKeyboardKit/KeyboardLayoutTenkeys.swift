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

struct KeyboardLayoutTenKeys: View {
    var body: some View {
        Grid {
            GridRow {
                KeyboardKeyView(key: "PrSn", code: .keyPrintScreen)
                KeyboardToggleKeyView(key: "ScLk", code: .keyScrollLock, modifier: .scrollLock)
                KeyboardKeyView(key: "Pause", code: .keyPause)
                Color.clear.frame(width: 20, height: 0)
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(4)
            }
            GridRow {
                KeyboardKeyView(key: "Ins", code: .keyInsert)
                KeyboardKeyView(key: "Home", code: .keyHome)
                KeyboardKeyView(key: "PgUp", code: .keyPageUp)
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                KeyboardToggleKeyView(key: "NmLk", code: .keyNumLock, modifier: .numLock)
                KeyboardKeyView(key: "/", code: .keyKeypadDivide)
                KeyboardKeyView(key: "*", code: .keyKeypadMultiply)
                KeyboardKeyView(key: "-", code: .keyKeypadMinus)
            }
            GridRow {
                KeyboardKeyView(key: "Del", code: .keyDelete)
                KeyboardKeyView(key: "End", code: .keyEnd)
                KeyboardKeyView(key: "PgDn", code: .keyPageDown)
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                KeyboardKeyView(key: "7", code: .keyKeypad7)
                KeyboardKeyView(key: "8", code: .keyKeypad8)
                KeyboardKeyView(key: "9", code: .keyKeypad9)
                GeometryReader { geo in
                    KeyboardKeyView(key: "+", code: .keyKeypadPlus, height: 110)
                }.gridCellUnsizedAxes([.horizontal, .vertical])
            }
            GridRow {
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(4)
                KeyboardKeyView(key: "4", code: .keyKeypad4)
                KeyboardKeyView(key: "5", code: .keyKeypad5)
                KeyboardKeyView(key: "6", code: .keyKeypad6)
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
            }
            GridRow {
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                KeyboardKeyView(key: "↑", code: .keyUpArrow, isDark: true)
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(2)
                KeyboardKeyView(key: "1", code: .keyKeypad1)
                KeyboardKeyView(key: "2", code: .keyKeypad2)
                KeyboardKeyView(key: "3", code: .keyKeypad3)
                GeometryReader { geo in
                    KeyboardKeyView(key: "↵", code: .keyKeypadEnter, height: 110, isDark: true)
                }.gridCellUnsizedAxes([.horizontal, .vertical])
            }
            GridRow {
                KeyboardKeyView(key: "←", code: .keyLeftArrow, isDark: true)
                KeyboardKeyView(key: "↓", code: .keyDownArrow, isDark: true)
                KeyboardKeyView(key: "→", code: .keyRightArrow, isDark: true)
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                KeyboardKeyView(key: "0", code: .keyKeypad0, width: 110)
                    .gridCellColumns(2)
                KeyboardKeyView(key: ".", code: .keyKeypadDecimal)
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
            }
        }
    }
}

#Preview {
    KeyboardLayoutTenKeys()
}
