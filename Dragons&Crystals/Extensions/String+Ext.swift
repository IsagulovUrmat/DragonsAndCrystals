
import Foundation

// MARK: - Extension для обработки цветов в консоли
extension String {
    var red: String { "\u{001B}[0;31m\(self)\u{001B}[0m" }
    var green: String { "\u{001B}[0;32m\(self)\u{001B}[0m" }
    var yellow: String { "\u{001B}[0;33m\(self)\u{001B}[0m" }
    var blue: String { "\u{001B}[0;34m\(self)\u{001B}[0m" }
    var magenta: String { "\u{001B}[0;35m\(self)\u{001B}[0m" }
    var cyan: String { "\u{001B}[0;36m\(self)\u{001B}[0m" }
    var white: String { "\u{001B}[0;37m\(self)\u{001B}[0m" }

    var bold: String { "\u{001B}[1m\(self)\u{001B}[0m" }
}
