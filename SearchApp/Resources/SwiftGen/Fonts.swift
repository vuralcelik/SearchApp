// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum SourceSansPro {
    internal static let black = FontConvertible(name: "SourceSansPro-Black", family: "Source Sans Pro", path: "SourceSansPro-Black.ttf")
    internal static let blackItalic = FontConvertible(name: "SourceSansPro-BlackItalic", family: "Source Sans Pro", path: "SourceSansPro-BlackItalic.ttf")
    internal static let bold = FontConvertible(name: "SourceSansPro-Bold", family: "Source Sans Pro", path: "SourceSansPro-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "SourceSansPro-BoldItalic", family: "Source Sans Pro", path: "SourceSansPro-BoldItalic.ttf")
    internal static let extraLight = FontConvertible(name: "SourceSansPro-ExtraLight", family: "Source Sans Pro", path: "SourceSansPro-ExtraLight.ttf")
    internal static let extraLightItalic = FontConvertible(name: "SourceSansPro-ExtraLightItalic", family: "Source Sans Pro", path: "SourceSansPro-ExtraLightItalic.ttf")
    internal static let italic = FontConvertible(name: "SourceSansPro-Italic", family: "Source Sans Pro", path: "SourceSansPro-Italic.ttf")
    internal static let light = FontConvertible(name: "SourceSansPro-Light", family: "Source Sans Pro", path: "SourceSansPro-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "SourceSansPro-LightItalic", family: "Source Sans Pro", path: "SourceSansPro-LightItalic.ttf")
    internal static let regular = FontConvertible(name: "SourceSansPro-Regular", family: "Source Sans Pro", path: "SourceSansPro-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "SourceSansPro-SemiBold", family: "Source Sans Pro", path: "SourceSansPro-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "SourceSansPro-SemiBoldItalic", family: "Source Sans Pro", path: "SourceSansPro-SemiBoldItalic.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraLight, extraLightItalic, italic, light, lightItalic, regular, semiBold, semiBoldItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [SourceSansPro.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(OSX)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
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
