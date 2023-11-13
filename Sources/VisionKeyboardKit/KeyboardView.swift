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

struct KeyboardView: View {
    @AppStorage("IsExpanded") private var isExpanded: Bool = false
    @AppStorage("Layout") private var layout: KeyboardLayoutType = .ansi
    @State private var state: KeyboardState

    init(for id: KeyboardIdentifier) {
        state = KeyboardState(for: id)
    }

    var body: some View {
        HStack {
            KeyboardLayoutANSI()
            if isExpanded {
                Color.clear.frame(width: 20, height: 0)
                KeyboardLayoutTenKeys()
            }
        }
        .onAppear {
            state.keyboardDidAppear()
        }
        .onDisappear {
            state.keyboardDidDisappear()
        }
        .keyboardOrnament()
        .fixedSize()
        .padding([.top, .bottom])
        .padding([.leading, .trailing], 20)
        .background(.black.opacity(0.25))
        .environment(state)
    }
}

#Preview {
    KeyboardView(for: .global)
}
