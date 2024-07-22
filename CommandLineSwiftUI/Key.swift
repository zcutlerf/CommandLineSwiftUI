import Foundation
import SwiftUI

enum Key: String, CaseIterable {
    case upArrow, downArrow, leftArrow, rightArrow, delete, escape, space, tab
    case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
    case num1, num2, num3, num4, num5, num6, num7, num8, num9, num0
    case backtick, hyphen, equals, squareBracketLeft, squareBracketRight, backslash, semicolon, apostrophe, comma, period, slash
    
    var keyEquivalent: KeyEquivalent {
        switch self {
        case .upArrow:
                .upArrow
        case .downArrow:
                .downArrow
        case .leftArrow:
                .leftArrow
        case .rightArrow:
                .rightArrow
        case .delete:
                .delete
        case .escape:
                .escape
        case .space:
                .space
        case .tab:
                .tab
        case .a, .b, .c, .d, .e, .f, .g, .h, .i, .j, .k, .l, .m, .n, .o, .p, .q, .r, .s, .t, .u, .v, .w, .x, .y, .z:
            KeyEquivalent(rawValue.first!)
        case .num1, .num2, .num3, .num4, .num5, .num6, .num7, .num8, .num9, .num0:
            KeyEquivalent(rawValue.last!)
        case .backtick:
            KeyEquivalent("`")
        case .hyphen:
            KeyEquivalent("-")
        case .equals:
            KeyEquivalent("=")
        case .squareBracketLeft:
            KeyEquivalent("[")
        case .squareBracketRight:
            KeyEquivalent("]")
        case .backslash:
            KeyEquivalent("\\")
        case .semicolon:
            KeyEquivalent(";")
        case .apostrophe:
            KeyEquivalent("'")
        case .comma:
            KeyEquivalent(",")
        case .period:
            KeyEquivalent(".")
        case .slash:
            KeyEquivalent("/")
        }
    }
    
    init?(keyEquivalent: KeyEquivalent) {
        switch keyEquivalent {
        case .upArrow:
            self = .upArrow
        case .downArrow:
            self = .downArrow
        case .leftArrow:
            self = .leftArrow
        case .rightArrow:
            self = .rightArrow
        case .delete:
            self = .delete
        case .escape:
            self = .escape
        case .space:
            self = .space
        case .tab:
            self = .tab
        default:
            if keyEquivalent.character.isNumber,
               let key = Key(rawValue: "num\(keyEquivalent.character)") {
                self = key
            }
            
            if let key = Key(rawValue: keyEquivalent.character.lowercased()) {
                self = key
            }
            
            return nil
        }
    }
}
