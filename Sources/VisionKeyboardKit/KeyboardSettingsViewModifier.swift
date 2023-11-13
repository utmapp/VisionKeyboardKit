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

struct KeyboardSettingsViewModifier: ViewModifier {
    @AppStorage("IsExpanded") private var isExpanded: Bool = false
    @AppStorage("Layout") private var layout: KeyboardLayoutType = .ansi

    func body(content: Content) -> some View {
        content.ornament(attachmentAnchor: .scene(.topLeading)) {
            Menu {
                ForEach(KeyboardLayoutType.allCases) { option in
                    Toggle(option.label, isOn: Binding {
                        layout == option
                    } set: { _ in
                        layout = option
                    })
                }
            } label: {
                Label("Layout…", systemImage: "globe")
            }.labelStyle(.iconOnly)
        }
        .ornament(attachmentAnchor: .scene(.topTrailing)) {
            if isExpanded {
                Button {
                    isExpanded = false
                } label: {
                    Label("Contract", systemImage: "chevron.left")
                }.labelStyle(.iconOnly)
            } else {
                Button {
                    isExpanded = true
                } label: {
                    Label("Expand", systemImage: "chevron.right")
                }.labelStyle(.iconOnly)
            }
        }
    }
}

extension View {
    func keyboardOrnament() -> some View {
        self.modifier(KeyboardSettingsViewModifier())
    }
}
