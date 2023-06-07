import UIKit

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
