import SwiftUI

@Observable
final class SettingsViewModel {
    static let shared = SettingsViewModel()
    
    private var changingTheTheme: Bool = false
    var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            changingTheTheme = true
        }
    }
    
    private init() {
        let value = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool
        let systemDark = UITraitCollection.current.userInterfaceStyle == .dark
        self.isDarkMode = value ?? systemDark
        self.changingTheTheme = (value != nil)
    }
    
    func resetChangingTheme(_ systemDark: Bool) {
        if !changingTheTheme {
            isDarkMode = systemDark
        }
    }
}
