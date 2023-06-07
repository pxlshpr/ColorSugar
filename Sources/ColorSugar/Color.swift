import SwiftUI

public extension Color {
    var brightness: CGFloat {
        UIColor(self).brightness
    }
}
