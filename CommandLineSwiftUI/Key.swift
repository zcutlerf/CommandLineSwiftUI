import Foundation
import SwiftUI

enum Key: String, CaseIterable {
    case upArrow, downArrow, leftArrow, rightArrow, delete, escape, space, tab, `return`
    case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
    case num1, num2, num3, num4, num5, num6, num7, num8, num9, num0
    case backtick = "`", hyphen = "-", equals = "=", squareBracketLeft = "[", squareBracketRight = "]", backslash = "\\", semicolon = ";", apostrophe = "'", comma = ",", period = ".", slash = "/"
    case none = "No keys pressed"
    
    var keyEquivalent: KeyEquivalent {
        switch self {
        case .none:
                .end
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
        case .return:
                .return
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
        case .return:
            self = .return
        default:
            if keyEquivalent.character.isNumber {
                self.init(rawValue: "num\(keyEquivalent.character)")
                return
            }
            
            self.init(rawValue: keyEquivalent.character.lowercased())
        }
    }
    
    static var letters: [Key] {
        [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]
    }
    
    static var numbers: [Key] {
        [num1, num2, num3, num4, num5, num6, num7, num8, num9, num0]
    }
    
    static var punctuation: [Key] {
        [backtick, hyphen, equals, squareBracketLeft, squareBracketRight, backslash, semicolon, apostrophe, comma, period, slash]
    }
    
    static var arrowKeys: [Key] {
        [upArrow, downArrow, leftArrow, rightArrow]
    }
}
