import SwiftUI

// MARK: - Perplexity Font Families

enum PPFontFamily {
    static let sans = "PPLX Sans Beta v0 VF"
    static let serif = "PPLX Serif Beta v0 VF"
    static let mono = "PPLX Mono Beta v0 VF"
    static let condensed = "GT Canon VF"
}

// MARK: - Perplexity Typography Scale

enum PPFont {

    // -- UI Text --

    /// 12/16, PPLX Sans, regular
    static let caption = Font.custom(PPFontFamily.sans, size: 12)
    /// 12/16, PPLX Sans, semibold
    static let captionStrong = Font.custom(PPFontFamily.sans, size: 12).weight(.semibold)

    /// 12/16, PPLX Mono, regular
    static let codeSm = Font.custom(PPFontFamily.mono, size: 12)
    /// 14/20, PPLX Mono, regular
    static let codeMd = Font.custom(PPFontFamily.mono, size: 14)

    /// 16/24, PPLX Sans, regular
    static let bodyMd = Font.custom(PPFontFamily.sans, size: 16)
    /// 16/24, PPLX Sans, semibold
    static let bodyMdStrong = Font.custom(PPFontFamily.sans, size: 16).weight(.semibold)

    /// 17/26, PPLX Sans, regular
    static let bodyLg = Font.custom(PPFontFamily.sans, size: 17)
    /// 17/26, PPLX Sans, semibold
    static let bodyLgStrong = Font.custom(PPFontFamily.sans, size: 17).weight(.semibold)

    // -- UI Heading --

    /// 18/26, PPLX Sans, semibold
    static let section = Font.custom(PPFontFamily.sans, size: 18).weight(.semibold)
    /// 20/28, PPLX Serif, semibold
    static let title = Font.custom(PPFontFamily.serif, size: 20).weight(.semibold)
    /// 24/32, GT Canon, medium
    static let headline = Font.custom(PPFontFamily.condensed, size: 24).weight(.medium)
    /// 38/48, GT Canon, medium
    static let display = Font.custom(PPFontFamily.condensed, size: 38).weight(.medium)
    /// 46/56, GT Canon, medium
    static let hero = Font.custom(PPFontFamily.condensed, size: 46).weight(.medium)

    // -- Article Text --

    /// 17/26, PPLX Serif, medium
    static let articleBodySerif = Font.custom(PPFontFamily.serif, size: 17).weight(.medium)
    /// 17/26, PPLX Sans, regular
    static let articleBodySans = Font.custom(PPFontFamily.sans, size: 17)
    /// 14/20, PPLX Mono, regular
    static let articleCode = Font.custom(PPFontFamily.mono, size: 14)

    // -- Article Heading --

    /// 19/28, PPLX Serif, semibold
    static let articleSectionSerif = Font.custom(PPFontFamily.serif, size: 19).weight(.semibold)
    /// 19/28, PPLX Sans, semibold
    static let articleSectionSans = Font.custom(PPFontFamily.sans, size: 19).weight(.semibold)
    /// 21/30, PPLX Serif, semibold
    static let articleTitleSerif = Font.custom(PPFontFamily.serif, size: 21).weight(.semibold)
    /// 21/30, PPLX Sans, semibold
    static let articleTitleSans = Font.custom(PPFontFamily.sans, size: 21).weight(.semibold)
    /// 24/32, GT Canon, medium
    static let articleHeadlineSerif = Font.custom(PPFontFamily.condensed, size: 24).weight(.medium)
    /// 24/32, PPLX Sans, semibold
    static let articleHeadlineSans = Font.custom(PPFontFamily.sans, size: 24).weight(.semibold)
}

// MARK: - Typography Token Metadata

enum PPTypographyToken {
    struct Spec {
        let fontFamily: String
        let fontSize: CGFloat
        let lineHeight: CGFloat
        let letterSpacing: CGFloat
        let fontWeight: Int
    }

    static let uiTextCaptionNormal = Spec(fontFamily: PPFontFamily.sans, fontSize: 12, lineHeight: 16, letterSpacing: -0.54, fontWeight: 400)
    static let uiTextCaptionStrong = Spec(fontFamily: PPFontFamily.sans, fontSize: 12, lineHeight: 16, letterSpacing: -0.54, fontWeight: 600)
    static let uiTextCodeSm = Spec(fontFamily: PPFontFamily.mono, fontSize: 12, lineHeight: 16, letterSpacing: -0.24, fontWeight: 400)
    static let uiTextCodeMd = Spec(fontFamily: PPFontFamily.mono, fontSize: 14, lineHeight: 20, letterSpacing: -0.56, fontWeight: 400)
    static let uiTextBodyMdNormal = Spec(fontFamily: PPFontFamily.sans, fontSize: 16, lineHeight: 24, letterSpacing: -0.72, fontWeight: 400)
    static let uiTextBodyMdStrong = Spec(fontFamily: PPFontFamily.sans, fontSize: 16, lineHeight: 24, letterSpacing: -0.72, fontWeight: 600)
    static let uiTextBodyLgNormal = Spec(fontFamily: PPFontFamily.sans, fontSize: 17, lineHeight: 26, letterSpacing: -0.72, fontWeight: 400)
    static let uiTextBodyLgStrong = Spec(fontFamily: PPFontFamily.sans, fontSize: 17, lineHeight: 26, letterSpacing: -0.72, fontWeight: 600)
    static let uiHeadingSection = Spec(fontFamily: PPFontFamily.sans, fontSize: 18, lineHeight: 26, letterSpacing: -0.81, fontWeight: 600)
    static let uiHeadingTitle = Spec(fontFamily: PPFontFamily.serif, fontSize: 20, lineHeight: 28, letterSpacing: -0.4, fontWeight: 600)
    static let uiHeadingHeadline = Spec(fontFamily: PPFontFamily.condensed, fontSize: 24, lineHeight: 32, letterSpacing: -0.48, fontWeight: 500)
    static let uiHeadingDisplay = Spec(fontFamily: PPFontFamily.condensed, fontSize: 38, lineHeight: 48, letterSpacing: -0.76, fontWeight: 500)
    static let uiHeadingHero = Spec(fontFamily: PPFontFamily.condensed, fontSize: 46, lineHeight: 56, letterSpacing: -0.92, fontWeight: 500)
}

// MARK: - Line Height Modifier

struct PPLineHeight: ViewModifier {
    let lineHeight: CGFloat
    let fontSize: CGFloat

    func body(content: Content) -> some View {
        content.lineSpacing(lineHeight - fontSize)
    }
}

extension View {
    func ppLineHeight(_ lineHeight: CGFloat, fontSize: CGFloat) -> some View {
        modifier(PPLineHeight(lineHeight: lineHeight, fontSize: fontSize))
    }
}

// MARK: - Tracking (Letter Spacing) Modifier

extension View {
    func ppTracking(_ letterSpacing: CGFloat) -> some View {
        tracking(letterSpacing)
    }
}
