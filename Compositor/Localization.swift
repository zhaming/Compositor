import Foundation

/// Localization helpers for text that SwiftUI cannot localize automatically.
///
/// SwiftUI resolves `LocalizedStringKey` only for **string literals** such as
/// `Text("Save")` or `Button("Cancel")`. When the text reaches the view as a
/// variable — an enum `rawValue`, an element of an array, or a computed
/// property — the compiler selects the `String` overload and the text is shown
/// verbatim, bypassing `Localizable.strings` entirely.
///
/// Wrapping those values with `.localized` restores lookup against
/// `Localizable.strings`, so menus, pickers and help tags built from enum
/// cases follow the user's language like literal labels do.
extension String {
    /// The translation of this string in the current bundle, or the string
    /// itself when no translation exists.
    var localized: String {
        Bundle.main.localizedString(forKey: self, value: self, table: nil)
    }
}

extension Optional where Wrapped == String {
    /// Localized text for an optional string, falling back to an empty string.
    var localized: String {
        switch self {
        case .some(let value): return value.localized
        case .none: return ""
        }
    }
}
