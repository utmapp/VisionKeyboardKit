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

/// Reference: https://babbage.cs.qc.cuny.edu/courses/cs345/Manuals/ms_scancode.pdf
public extension KeyboardKeyCode {
    private var ps2Set1ScanBase: [UInt8] {
        switch self {
        case .keyGrave: return [0x29]
        case .key1: return [0x02]
        case .key2: return [0x03]
        case .key3: return [0x04]
        case .key4: return [0x05]
        case .key5: return [0x06]
        case .key6: return [0x07]
        case .key7: return [0x08]
        case .key8: return [0x09]
        case .key9: return [0x0a]
        case .key0: return [0x0b]
        case .keyMinus: return [0x0c]
        case .keyEqual: return [0x0d]
        case .keyBackspace: return [0x0e]
        case .keyTab: return [0x0f]
        case .keyQ: return [0x10]
        case .keyW: return [0x11]
        case .keyE: return [0x12]
        case .keyR: return [0x13]
        case .keyT: return [0x14]
        case .keyY: return [0x15]
        case .keyU: return [0x16]
        case .keyI: return [0x17]
        case .keyO: return [0x18]
        case .keyP: return [0x19]
        case .keyRightBracket: return [0x1a]
        case .keyLeftBracket: return [0x1b]
        case .keyBackslash: return [0x1c]
        case .keyCapsLock: return [0x3a]
        case .keyA: return [0x1e]
        case .keyS: return [0x1f]
        case .keyD: return [0x20]
        case .keyF: return [0x21]
        case .keyG: return [0x22]
        case .keyH: return [0x23]
        case .keyJ: return [0x24]
        case .keyK: return [0x25]
        case .keyL: return [0x26]
        case .keySemicolon: return [0x27]
        case .keyQuote: return [0x28]
        case .keyInternational42: return [0x2b]
        case .keyReturn: return [0x1c]
        case .keyShift: return [0x2a]
        case .keyInternational45: return [0x56]
        case .keyZ: return [0x2c]
        case .keyX: return [0x2d]
        case .keyC: return [0x2e]
        case .keyV: return [0x2f]
        case .keyB: return [0x30]
        case .keyN: return [0x31]
        case .keyM: return [0x32]
        case .keyComma: return [0x33]
        case .keyPeriod: return [0x34]
        case .keySlash: return [0x35]
        case .keyRightShift: return [0x36]
        case .keyControl: return [0x1d]
        case .keyOption: return [0x38]
        case .keySpace: return [0x39]
        case .keyRightOption: return [0xe0, 0x38]
        case .keyRightControl: return [0xe0, 0x1d]
        case .keyInsert: return [0xe0, 0x52]
        case .keyDelete: return [0xe0, 0x53]
        case .keyLeftArrow: return [0xe0, 0x4b]
        case .keyHome: return [0xe0, 0x47]
        case .keyEnd: return [0xe0, 0x4f]
        case .keyUpArrow: return [0xe0, 0x48]
        case .keyDownArrow: return [0xe0, 0x50]
        case .keyPageUp: return [0xe0, 0x49]
        case .keyPageDown: return [0xe0, 0x51]
        case .keyRightArrow: return [0xe0, 0x4d]
        case .keyNumLock: return [0x45]
        case .keyKeypad7: return [0x47]
        case .keyKeypad4: return [0x4b]
        case .keyKeypad1: return [0x4f]
        case .keyKeypadDivide: return [0xe0, 0x35]
        case .keyKeypad8: return [0x48]
        case .keyKeypad5: return [0x4c]
        case .keyKeypad2: return [0x50]
        case .keyKeypad0: return [0x52]
        case .keyKeypadMultiply: return [0x37]
        case .keyKeypad9: return [0x49]
        case .keyKeypad6: return [0x4d]
        case .keyKeypad3: return [0x51]
        case .keyKeypadDecimal: return [0x53]
        case .keyKeypadMinus: return [0x4a]
        case .keyKeypadPlus: return [0x4e]
        case .keyInternational107: return [0x7e]
        case .keyKeypadEnter: return [0xe0, 0x1c]
        case .keyEscape: return [0x01]
        case .keyF1: return [0x3b]
        case .keyF2: return [0x3c]
        case .keyF3: return [0x3d]
        case .keyF4: return [0x3e]
        case .keyF5: return [0x3f]
        case .keyF6: return [0x40]
        case .keyF7: return [0x41]
        case .keyF8: return [0x42]
        case .keyF9: return [0x43]
        case .keyF10: return [0x44]
        case .keyF11: return [0x57]
        case .keyF12: return [0x58]
        case .keyPrintScreen: return [0xe0, 0x2a, 0xe0, 0x37]
        case .keyScrollLock: return [0x46]
        case .keyPause: return [0xe1, 0x1d, 0x45, 0xe1, 0x9d, 0xc5]
        case .keyCommand: return [0xe0, 0x5b]
        case .keyRightCommand: return [0xe0, 0x5c]
        case .keyApplication: return [0xe0, 0x5d]
        case .keyACPIPower: return [0xe0, 0x5e]
        case .keyACPISleep: return [0xe0, 0x5f]
        case .keyACPIWake: return [0xe0, 0x63]
        case .keyJISYen: return [0x7d]
        case .keyJISUnderscore: return [0x73]
        case .keyJISEisu: return [0x7b]
        case .keyJISKana: return [0x79]
        }
    }
    
    /// Generate a PS/2 compatible set 1 scan code (make)
    /// - Parameter modifiers: Optional modifiers which may affect scan code output.
    /// - Returns: A byte array of scan codes.
    func ps2Set1ScanMake(_ modifiers: KeyboardModifier = .none) -> [UInt8] {
        let base = ps2Set1ScanBase
        let shiftModifier = { (base: [UInt8]) -> [UInt8] in
            var prefix = [UInt8]()
            if modifiers.contains(.leftShift) {
                prefix = [0xe0, 0xaa]
            }
            if modifiers.contains(.rightShift) {
                prefix = prefix + [0xe0, 0xb6]
            }
            return prefix + base
        }
        switch self {
            // note 1
        case .keyInsert, .keyDelete, .keyLeftArrow, .keyHome, .keyEnd, .keyUpArrow, .keyDownArrow, .keyPageUp, .keyPageDown, .keyRightArrow:
            if modifiers.contains(.numLock) {
                return [0xe0, 0x2a] + base
            } else {
                return shiftModifier(base)
            }
            // note 3
        case .keyKeypadDivide:
            return shiftModifier(base)
            // note 4
        case .keyPrintScreen:
            if modifiers.contains(.leftControl) {
                return [0xe0, 0x37]
            } else if modifiers.contains(.rightControl) && !modifiers.isDisjoint(with: [.leftShift, .rightShift]) {
                return [0xe0, 0x37]
            } else if !modifiers.isDisjoint(with: [.leftOption, .rightOption]) {
                return [0x54]
            } else {
                return base
            }
            // note 5
        case .keyPause:
            if !modifiers.isDisjoint(with: [.leftControl, .rightControl]) {
                return [0xe0, 0x46, 0xe0, 0xc6]
            } else {
                return base
            }
        default:
            return base
        }
    }

    /// Generate a PS/2 compatible set 1 scan code (break)
    /// - Parameter modifiers: Optional modifiers which may affect scan code output.
    /// - Returns: A byte array of scan codes.
    func ps2Set1ScanBreak(_ modifiers: KeyboardModifier = .none) -> [UInt8] {
        let base = ps2Set1ScanBase.map({ $0 | 0x80 })
        let shiftModifier = { (base: [UInt8]) -> [UInt8] in
            var suffix = [UInt8]()
            if modifiers.contains(.rightShift) {
                suffix = [0xe0, 0x36]
            }
            if modifiers.contains(.leftShift) {
                suffix = suffix + [0xe0, 0x2a]
            }
            return base + suffix
        }
        switch self {
            // note 1
        case .keyInsert, .keyDelete, .keyLeftArrow, .keyHome, .keyEnd, .keyUpArrow, .keyDownArrow, .keyPageUp, .keyPageDown, .keyRightArrow:
            if modifiers.contains(.numLock) {
                return base + [0xe0, 0xaa]
            } else {
                return shiftModifier(base)
            }
            // note 3
        case .keyKeypadDivide:
            return shiftModifier(base)
            // note 4
        case .keyPrintScreen:
            if modifiers.contains(.leftControl) {
                return [0xe0, 0xb7]
            } else if modifiers.contains(.rightControl) && !modifiers.isDisjoint(with: [.leftShift, .rightShift]) {
                return [0xe0, 0xb7]
            } else if !modifiers.isDisjoint(with: [.leftOption, .rightOption]) {
                return [0xd4]
            } else {
                return base
            }
            // note 5
        case .keyPause:
            return []
        default:
            return base
        }
    }
}
