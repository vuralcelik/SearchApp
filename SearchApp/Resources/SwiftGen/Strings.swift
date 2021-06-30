// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Cast Members
  internal static let movieDetailCastMembersHeaderTitle = L10n.tr("Localizable", "movie_detail_cast_members_header_title")
  /// Informations
  internal static let movieDetailInformationsHeaderTitle = L10n.tr("Localizable", "movie_detail_informations_header_title")
  /// Movie Detail
  internal static let movieDetailNavTitle = L10n.tr("Localizable", "movie_detail_nav_title")
  /// Videos
  internal static let movieDetailVideosHeaderTitle = L10n.tr("Localizable", "movie_detail_videos_header_title")
  /// Credits
  internal static let peopleDetailCreditTitle = L10n.tr("Localizable", "people_detail_credit_title")
  /// People Detail
  internal static let peopleDetailNavTitle = L10n.tr("Localizable", "people_detail_nav_title")
  /// Okay
  internal static let popUpButtonOkayTitle = L10n.tr("Localizable", "pop_up_button_okay_title")
  /// Error
  internal static let popUpErrorTitle = L10n.tr("Localizable", "pop_up_error_title")
  /// Cancel
  internal static let searchBarCancelTitle = L10n.tr("Localizable", "search_bar_cancel_title")
  /// Search movie or artist
  internal static let searchBarPlaceholderText = L10n.tr("Localizable", "search_bar_placeholder_text")
  /// There is no data yet.
  internal static let searchEmptyInfoTitle = L10n.tr("Localizable", "search_empty_info_title")
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
