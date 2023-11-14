//
// Copyright © 2023 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License")
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

import Combine
import os

/// Events posted by the keyboard
public enum KeyboardEvent {
    /// Sent from the keyboard view's `onAppear()`
    case keyboardDidAppear
    /// Sent from the keyboard view's `onDisappear()`
    case keyboardDidDisappear
    /// Sent when a keyboard key is held down
    case keyDown(KeyboardKeyCode, modifier: KeyboardModifier)
    /// Sent when a keyboard key is released
    case keyUp(KeyboardKeyCode, modifier: KeyboardModifier)

    static func subject(for id: KeyboardIdentifier) -> KeyboardEventSubject {
        KeyboardEventSubject.for(id)
    }

    /// Returns a publisher that emits events from the keyboard.
    /// - Parameter id: A `KeyboardIdentifier` that uniquely identifies this keyboard instance.
    /// - Returns: A `Publisher` that emits events from the keyboard.
    public static func publisher(for id: KeyboardIdentifier) -> AnyPublisher<KeyboardEvent, Never> {
        KeyboardEventSubject.for(id).eraseToAnyPublisher()
    }
    
    /// Returns a publisher that emits events from the keyboard.
    /// - Parameter id: Unique identifier for the keyboard to handle events from.
    /// - Returns: A `Publisher` that emits events from the keyboard.
    public static func publisher<H: Hashable>(for id: H) -> AnyPublisher<KeyboardEvent, Never> {
        publisher(for: KeyboardIdentifier(for: id))
    }
}

/// Modifier key state
public struct KeyboardModifier: OptionSet {
    public let rawValue: Int

    public static var none = KeyboardModifier(rawValue: 0)
    public static var leftShift = KeyboardModifier(rawValue: 1 << 0)
    public static var rightShift = KeyboardModifier(rawValue: 1 << 1)
    public static var leftControl = KeyboardModifier(rawValue: 1 << 2)
    public static var rightControl = KeyboardModifier(rawValue: 1 << 3)
    public static var leftOption = KeyboardModifier(rawValue: 1 << 4)
    public static var rightOption = KeyboardModifier(rawValue: 1 << 5)
    public static var leftCommand = KeyboardModifier(rawValue: 1 << 6)
    public static var rightCommand = KeyboardModifier(rawValue: 1 << 7)
    public static var capsLock = KeyboardModifier(rawValue: 1 << 8)
    public static var scrollLock = KeyboardModifier(rawValue: 1 << 9)
    public static var numLock = KeyboardModifier(rawValue: 1 << 10)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    mutating func removeNontoggle() {
        subtract([.leftShift, .rightShift, .leftControl, .rightControl, .leftCommand, .rightCommand, .leftOption, .rightOption])
    }
}

public enum KeyboardKeyCode {
    case key0
    case key1
    case key2
    case key3
    case key4
    case key5
    case key6
    case key7
    case key8
    case key9
    case keyA
    case keyACPIPower
    case keyACPISleep
    case keyACPIWake
    case keyApplication
    case keyB
    case keyBackslash
    case keyBackspace
    case keyC
    case keyCapsLock
    case keyComma
    case keyCommand
    case keyControl
    case keyD
    case keyDelete
    case keyDownArrow
    case keyE
    case keyEnd
    case keyEqual
    case keyEscape
    case keyF
    case keyF1
    case keyF10
    case keyF11
    case keyF12
    case keyF2
    case keyF3
    case keyF4
    case keyF5
    case keyF6
    case keyF7
    case keyF8
    case keyF9
    case keyG
    case keyGrave
    case keyH
    case keyHome
    case keyI
    case keyInsert
    case keyInternational107
    case keyInternational42
    case keyInternational45
    case keyJ
    case keyJISEisu
    case keyJISKana
    case keyJISUnderscore
    case keyJISYen
    case keyK
    case keyKeypad0
    case keyKeypad1
    case keyKeypad2
    case keyKeypad3
    case keyKeypad4
    case keyKeypad5
    case keyKeypad6
    case keyKeypad7
    case keyKeypad8
    case keyKeypad9
    case keyKeypadDecimal
    case keyKeypadDivide
    case keyKeypadEnter
    case keyKeypadMinus
    case keyKeypadMultiply
    case keyKeypadPlus
    case keyL
    case keyLeftArrow
    case keyLeftBracket
    case keyM
    case keyMinus
    case keyN
    case keyNumLock
    case keyO
    case keyOption
    case keyP
    case keyPageDown
    case keyPageUp
    case keyPause
    case keyPeriod
    case keyPrintScreen
    case keyQ
    case keyQuote
    case keyR
    case keyReturn
    case keyRightArrow
    case keyRightBracket
    case keyRightCommand
    case keyRightControl
    case keyRightOption
    case keyRightShift
    case keyS
    case keyScrollLock
    case keySemicolon
    case keyShift
    case keySlash
    case keySpace
    case keyT
    case keyTab
    case keyU
    case keyUpArrow
    case keyV
    case keyW
    case keyX
    case keyY
    case keyZ

    var isModifier: Bool {
        switch self {
        case .keyShift, .keyRightShift, .keyControl, .keyRightControl, .keyCommand, .keyRightCommand, .keyOption, .keyRightOption:
            return true
        case .keyCapsLock, .keyNumLock, .keyScrollLock:
            return true
        default:
            return false
        }
    }
}

/// Box for holding a weak reference
private struct Weak<S: AnyObject> {
    weak var ref: S?
}

/// We maintain a map of `KeyboardIdentifier` to `KeyboardEventSubject` in order to maintain that
/// each identifier gets a unique instance of the `Subject`. When they keyboard view posts events to the `Subject`,
/// any `Publisher` who is listening to it shall receive the event.
///
/// Once all references are dropped, that means that the keyboard window is closed and all listeners have released
/// their reference and so it is safe to clean up the map entry (which should be holding a box with a nil reference).
/// We make sure all this is done in a thread safe manner by the use of `subjectsLock`.
final class KeyboardEventSubject: Subject {
    typealias Output = KeyboardEvent
    typealias Failure = Never

    private static var subjectsLock = OSAllocatedUnfairLock()
    private static var allSubjects: [KeyboardIdentifier: Weak<KeyboardEventSubject>] = [:]
    private let id: KeyboardIdentifier
    private let underlyingSubject = PassthroughSubject<Output, Failure>()

    private init(for id: KeyboardIdentifier) {
        self.id = id
    }

    static func `for`(_ id: KeyboardIdentifier) -> KeyboardEventSubject {
        subjectsLock.withLock {
            if let w = allSubjects[id], let s = w.ref {
                return s
            } else {
                let s = KeyboardEventSubject(for: id)
                allSubjects[id] = Weak(ref: s)
                return s
            }
        }
    }

    deinit {
        Self.subjectsLock.withLock {
            _ = Self.allSubjects.removeValue(forKey: id)
        }
    }

    func send(subscription: Subscription) {
        underlyingSubject.send(subscription: subscription)
    }

    func receive<S>(subscriber: S) where KeyboardEvent == S.Input, Never == S.Failure, S : Subscriber {
        underlyingSubject.receive(subscriber: subscriber)
    }

    func send(_ input: KeyboardEvent) {
        underlyingSubject.send(input)
    }

    func send(completion: Subscribers.Completion<Never>) {
        underlyingSubject.send(completion: completion)
    }
}
