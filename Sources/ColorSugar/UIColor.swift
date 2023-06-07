import UIKit

public extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            alpha: Double(a) / 255
        )
    }
}

public func +(left: UIColor, right: UIColor) -> UIColor {
    var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    left.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    right.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    return UIColor(red: (r1 + r2)/2, green: (g1 + g2)/2, blue: (b1 + b2)/2, alpha: (a1 + a2)/2)
}

/// Taken from: https://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
/// which references: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
///
public extension UIColor {
    
    var brightness: CGFloat {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard self.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return 0
        }
        
        let brightness = (((r*255)*299) + ((g*255)*587) + ((b*255)*114))/1000.0
        return brightness
    }
    
    var isLight: Bool {
        brightness > 125
    }
    
    /// My own addition, with an arbitrary value I used in Choons to determine if an artwork is dark
    var isDark: Bool {
        brightness <= 10
    }
}

import ColorKit

public extension UIColor {
    func isDifferentFrom(others: [UIColor], threshold: CGFloat = 25.0) -> Bool {
        for other in others {
            let difference = difference(from: other, using: .CIE76)
            guard difference.associatedValue > threshold else {
                return false
            }
        }
        return true
    }
}

public extension UIColor.ColorDifferenceResult {
    var associatedValue: CGFloat {
        switch self {
        case .indentical(let value),
             .similar(let value),
             .close(let value),
             .near(let value),
             .different(let value),
             .far(let value):
             return value
        }
    }
}
