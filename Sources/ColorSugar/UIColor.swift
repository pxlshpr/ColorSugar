import UIKit

public func +(left: UIColor, right: UIColor) -> UIColor {
    var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
    left.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    right.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    return UIColor(red: (r1 + r2)/2, green: (g1 + g2)/2, blue: (b1 + b2)/2, alpha: (a1 + a2)/2)
}
