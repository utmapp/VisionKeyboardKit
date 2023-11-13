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

/// Instantiate this in your `Scene` to support keyboard windows.
///
/// Use `OpenWindowAction.callAsFunction(keyboardFor:)` to show the keyboard.
public struct KeyboardWindowGroup: Scene {
    public init(){}

    public var body: some Scene {
        WindowGroup(for: KeyboardIdentifier.self) { $id in
            KeyboardView(for: id ?? .global)
        }
        .windowResizability(.contentSize)
    }
}

public extension OpenWindowAction {
    /// Opens a keyboard window
    /// - Parameter id: Any `Hashable` object that uniquely identifies this keyboard instance.
    func callAsFunction<ID>(keyboardFor id: ID) where ID: Hashable {
        callAsFunction(value: KeyboardIdentifier(for: id))
    }
    
    /// Opens a keyboard window
    /// - Parameter id: A `KeyboardIdentifier` that uniquely identifies this keyboard instance.
    func callAsFunction(keyboardFor id: KeyboardIdentifier) {
        callAsFunction(value: id)
    }
}

public extension DismissWindowAction {
    /// Closes a keyboard window
    /// - Parameter id: Any `Hashable` object that uniquely identifies this keyboard instance.
    func callAsFunction<ID>(keyboardFor id: ID) where ID: Hashable {
        callAsFunction(value: KeyboardIdentifier(for: id))
    }

    /// Closes a keyboard window
    /// - Parameter id: A `KeyboardIdentifier` that uniquely identifies this keyboard instance.
    func callAsFunction(keyboardFor id: KeyboardIdentifier) {
        callAsFunction(value: id)
    }
}
