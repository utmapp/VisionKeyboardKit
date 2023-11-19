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

@Observable
class KeyboardState {
    private let id: KeyboardIdentifier
    private let subject: KeyboardEventSubject

    let clicker = KeyboardClickSound()

    var modifier: KeyboardModifier = .none

    init(for id: KeyboardIdentifier) {
        self.id = id
        self.subject = KeyboardEvent.subject(for: id)
    }

    func keyboardDidAppear() {
        subject.send(.keyboardDidAppear)
    }

    func keyboardDidDisappear() {
        subject.send(.keyboardDidDisappear)
    }

    func keyDown(_ code: KeyboardKeyCode) {
        subject.send(.keyDown(code, modifier: modifier))
    }

    func keyUp(_ code: KeyboardKeyCode) {
        subject.send(.keyUp(code, modifier: modifier))
        if !code.isModifier {
            modifier.removeNontoggle()
        }
    }
}
