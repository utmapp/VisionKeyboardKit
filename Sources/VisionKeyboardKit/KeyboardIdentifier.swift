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

/// Represents a unique instance of the keyboard.
public struct KeyboardIdentifier: Codable, Hashable {
    private let id: Int
    
    /// Use this if your app only needs one instance of the keyboard.
    public static let global = KeyboardIdentifier(for: 0)

    init(for id: any Hashable) {
        self.id = id.hashValue
    }
}
