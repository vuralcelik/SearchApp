// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Cancel
  internal static let searchBarCancelTitle = L10n.tr("Localizable", "search_bar_cancel_title")
  /// Search movie or artist
  internal static let searchBarPlaceholderText = L10n.tr("Localizable", "search_bar_placeholder_text")
  /// Movies
  internal static let searchMovieHeaderTitle = L10n.tr("Localizable", "search_movie_header_title")
  /// Search
  internal static let searchNavTitle = L10n.tr("Localizable", "search_nav_title")
  /// Peoples
  internal static let searchPeopleHeaderTitle = L10n.tr("Localizable", "search_people_header_title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
