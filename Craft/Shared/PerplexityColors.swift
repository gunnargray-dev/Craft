import SwiftUI

// MARK: - Perplexity Palette Colors

public extension Color {
    // Gray (Odin)
    static let gray100 = Color(red: 0.969, green: 0.980, blue: 0.988, opacity: 1)
    static let gray200 = Color(red: 0.929, green: 0.949, blue: 0.969, opacity: 1)
    static let gray300 = Color(red: 0.886, green: 0.910, blue: 0.941, opacity: 1)
    static let gray400 = Color(red: 0.796, green: 0.835, blue: 0.878, opacity: 1)
    static let gray500 = Color(red: 0.627, green: 0.682, blue: 0.753, opacity: 1)
    static let gray600 = Color(red: 0.443, green: 0.502, blue: 0.588, opacity: 1)
    static let gray700 = Color(red: 0.290, green: 0.333, blue: 0.408, opacity: 1)
    static let gray800 = Color(red: 0.176, green: 0.216, blue: 0.282, opacity: 1)
    static let gray900 = Color(red: 0.102, green: 0.125, blue: 0.173, opacity: 1)

    // Red (Ifrit)
    static let red100 = Color(red: 1.000, green: 0.961, blue: 0.961, opacity: 1)
    static let red200 = Color(red: 0.996, green: 0.843, blue: 0.843, opacity: 1)
    static let red300 = Color(red: 0.996, green: 0.698, blue: 0.698, opacity: 1)
    static let red400 = Color(red: 0.988, green: 0.506, blue: 0.506, opacity: 1)
    static let red500 = Color(red: 0.961, green: 0.396, blue: 0.396, opacity: 1)
    static let red600 = Color(red: 0.898, green: 0.243, blue: 0.243, opacity: 1)
    static let red700 = Color(red: 0.773, green: 0.188, blue: 0.188, opacity: 1)
    static let red800 = Color(red: 0.608, green: 0.173, blue: 0.173, opacity: 1)
    static let red900 = Color(red: 0.455, green: 0.165, blue: 0.165, opacity: 1)

    // Orange (Phoenix)
    static let orange100 = Color(red: 1.000, green: 0.980, blue: 0.941, opacity: 1)
    static let orange200 = Color(red: 0.996, green: 0.922, blue: 0.784, opacity: 1)
    static let orange300 = Color(red: 0.984, green: 0.827, blue: 0.553, opacity: 1)
    static let orange400 = Color(red: 0.965, green: 0.678, blue: 0.333, opacity: 1)
    static let orange500 = Color(red: 0.929, green: 0.537, blue: 0.212, opacity: 1)
    static let orange600 = Color(red: 0.867, green: 0.420, blue: 0.125, opacity: 1)
    static let orange700 = Color(red: 0.753, green: 0.337, blue: 0.129, opacity: 1)
    static let orange800 = Color(red: 0.612, green: 0.259, blue: 0.129, opacity: 1)
    static let orange900 = Color(red: 0.482, green: 0.204, blue: 0.118, opacity: 1)

    // Yellow (Sylph)
    static let yellow100 = Color(red: 1.000, green: 1.000, blue: 0.941, opacity: 1)
    static let yellow200 = Color(red: 0.996, green: 0.988, blue: 0.749, opacity: 1)
    static let yellow300 = Color(red: 0.980, green: 0.941, blue: 0.537, opacity: 1)
    static let yellow400 = Color(red: 0.965, green: 0.878, blue: 0.369, opacity: 1)
    static let yellow500 = Color(red: 0.925, green: 0.788, blue: 0.294, opacity: 1)
    static let yellow600 = Color(red: 0.839, green: 0.620, blue: 0.180, opacity: 1)
    static let yellow700 = Color(red: 0.718, green: 0.475, blue: 0.122, opacity: 1)
    static let yellow800 = Color(red: 0.592, green: 0.353, blue: 0.086, opacity: 1)
    static let yellow900 = Color(red: 0.455, green: 0.259, blue: 0.063, opacity: 1)

    // Green (Garuda)
    static let green100 = Color(red: 0.941, green: 1.000, blue: 0.957, opacity: 1)
    static let green200 = Color(red: 0.776, green: 0.965, blue: 0.835, opacity: 1)
    static let green300 = Color(red: 0.604, green: 0.902, blue: 0.706, opacity: 1)
    static let green400 = Color(red: 0.408, green: 0.827, blue: 0.569, opacity: 1)
    static let green500 = Color(red: 0.282, green: 0.733, blue: 0.471, opacity: 1)
    static let green600 = Color(red: 0.220, green: 0.631, blue: 0.412, opacity: 1)
    static let green700 = Color(red: 0.184, green: 0.522, blue: 0.353, opacity: 1)
    static let green800 = Color(red: 0.153, green: 0.404, blue: 0.286, opacity: 1)
    static let green900 = Color(red: 0.133, green: 0.329, blue: 0.239, opacity: 1)

    // Teal (Shiva)
    static let teal100 = Color(red: 0.902, green: 1.000, blue: 0.980, opacity: 1)
    static let teal200 = Color(red: 0.698, green: 0.961, blue: 0.918, opacity: 1)
    static let teal300 = Color(red: 0.506, green: 0.902, blue: 0.851, opacity: 1)
    static let teal400 = Color(red: 0.310, green: 0.820, blue: 0.773, opacity: 1)
    static let teal500 = Color(red: 0.220, green: 0.698, blue: 0.675, opacity: 1)
    static let teal600 = Color(red: 0.192, green: 0.592, blue: 0.584, opacity: 1)
    static let teal700 = Color(red: 0.173, green: 0.478, blue: 0.482, opacity: 1)
    static let teal800 = Color(red: 0.157, green: 0.369, blue: 0.380, opacity: 1)
    static let teal900 = Color(red: 0.137, green: 0.306, blue: 0.322, opacity: 1)

    // Blue (Leviathan)
    static let blue100 = Color(red: 0.922, green: 0.973, blue: 1.000, opacity: 1)
    static let blue200 = Color(red: 0.745, green: 0.890, blue: 0.973, opacity: 1)
    static let blue300 = Color(red: 0.565, green: 0.804, blue: 0.957, opacity: 1)
    static let blue400 = Color(red: 0.388, green: 0.702, blue: 0.929, opacity: 1)
    static let blue500 = Color(red: 0.259, green: 0.600, blue: 0.882, opacity: 1)
    static let blue600 = Color(red: 0.192, green: 0.510, blue: 0.808, opacity: 1)
    static let blue700 = Color(red: 0.169, green: 0.424, blue: 0.690, opacity: 1)
    static let blue800 = Color(red: 0.173, green: 0.322, blue: 0.510, opacity: 1)
    static let blue900 = Color(red: 0.165, green: 0.263, blue: 0.396, opacity: 1)

    // Indigo (Fenrir)
    static let indigo100 = Color(red: 0.922, green: 0.957, blue: 1.000, opacity: 1)
    static let indigo200 = Color(red: 0.765, green: 0.855, blue: 0.996, opacity: 1)
    static let indigo300 = Color(red: 0.639, green: 0.749, blue: 0.980, opacity: 1)
    static let indigo400 = Color(red: 0.498, green: 0.612, blue: 0.961, opacity: 1)
    static let indigo500 = Color(red: 0.400, green: 0.494, blue: 0.918, opacity: 1)
    static let indigo600 = Color(red: 0.353, green: 0.404, blue: 0.847, opacity: 1)
    static let indigo700 = Color(red: 0.298, green: 0.318, blue: 0.749, opacity: 1)
    static let indigo800 = Color(red: 0.263, green: 0.255, blue: 0.565, opacity: 1)
    static let indigo900 = Color(red: 0.235, green: 0.212, blue: 0.420, opacity: 1)

    // Purple (Ramuh)
    static let purple100 = Color(red: 0.980, green: 0.961, blue: 1.000, opacity: 1)
    static let purple200 = Color(red: 0.914, green: 0.847, blue: 0.992, opacity: 1)
    static let purple300 = Color(red: 0.839, green: 0.737, blue: 0.980, opacity: 1)
    static let purple400 = Color(red: 0.718, green: 0.580, blue: 0.957, opacity: 1)
    static let purple500 = Color(red: 0.624, green: 0.478, blue: 0.918, opacity: 1)
    static let purple600 = Color(red: 0.502, green: 0.353, blue: 0.835, opacity: 1)
    static let purple700 = Color(red: 0.420, green: 0.275, blue: 0.757, opacity: 1)
    static let purple800 = Color(red: 0.333, green: 0.235, blue: 0.604, opacity: 1)
    static let purple900 = Color(red: 0.267, green: 0.200, blue: 0.478, opacity: 1)

    // Pink (Jenova)
    static let pink100 = Color(red: 1.000, green: 0.961, blue: 0.969, opacity: 1)
    static let pink200 = Color(red: 0.996, green: 0.843, blue: 0.886, opacity: 1)
    static let pink300 = Color(red: 0.984, green: 0.714, blue: 0.808, opacity: 1)
    static let pink400 = Color(red: 0.965, green: 0.529, blue: 0.702, opacity: 1)
    static let pink500 = Color(red: 0.929, green: 0.392, blue: 0.651, opacity: 1)
    static let pink600 = Color(red: 0.835, green: 0.247, blue: 0.549, opacity: 1)
    static let pink700 = Color(red: 0.722, green: 0.196, blue: 0.502, opacity: 1)
    static let pink800 = Color(red: 0.592, green: 0.149, blue: 0.427, opacity: 1)
    static let pink900 = Color(red: 0.439, green: 0.141, blue: 0.349, opacity: 1)
}

// MARK: - Perplexity Semantic Colors

public extension Color {

    // -- Foreground --
    static let fgPrimary = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.145, blue: 0.118, opacity: 1),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 1)
    )
    static let fgSecondary = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.145, blue: 0.118, opacity: 0.65),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 0.65)
    )
    static let fgTertiary = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.145, blue: 0.118, opacity: 0.4),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 0.4)
    )
    static let fgInverse = Color.dynamicColor(
        light: Color(red: 0.992, green: 0.984, blue: 0.980, opacity: 1),
        dark: Color(red: 0.090, green: 0.086, blue: 0.082, opacity: 1)
    )

    // -- Background --
    static let bgInverse = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.145, blue: 0.118, opacity: 1),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 1)
    )
    static let bgSoft = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.102, blue: 0.000, opacity: 0.07),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 0.07)
    )
    static let bgSubtle = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.102, blue: 0.000, opacity: 0.035),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 0.035)
    )
    static let bgBase = Color.dynamicColor(
        light: Color(red: 0.980, green: 0.973, blue: 0.961, opacity: 1),
        dark: Color(red: 0.090, green: 0.086, blue: 0.082, opacity: 1)
    )
    static let bgRaised = Color.dynamicColor(
        light: Color(red: 0.992, green: 0.984, blue: 0.980, opacity: 1),
        dark: Color(red: 0.118, green: 0.114, blue: 0.110, opacity: 1)
    )

    // -- Border --
    static let borderHeavy = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.145, blue: 0.118, opacity: 1),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 1)
    )
    static let borderBase = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.102, blue: 0.000, opacity: 0.14),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 0.14)
    )
    static let borderSoft = Color.dynamicColor(
        light: Color(red: 0.153, green: 0.102, blue: 0.000, opacity: 0.07),
        dark: Color(red: 0.839, green: 0.835, blue: 0.831, opacity: 0.07)
    )
    static let borderInverse = Color.dynamicColor(
        light: Color(red: 0.992, green: 0.984, blue: 0.980, opacity: 1),
        dark: Color(red: 0.090, green: 0.086, blue: 0.082, opacity: 1)
    )
    static let borderFocus = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.416, blue: 0.443, opacity: 1),
        dark: Color(red: 0.306, green: 0.600, blue: 0.639, opacity: 1)
    )

    // -- Accent (Shiva / Teal) --
    static let accentFgPrimary = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.416, blue: 0.443, opacity: 1),
        dark: Color(red: 0.306, green: 0.600, blue: 0.639, opacity: 1)
    )
    static let accentFgSecondary = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.416, blue: 0.443, opacity: 0.65),
        dark: Color(red: 0.306, green: 0.600, blue: 0.639, opacity: 0.65)
    )
    static let accentBgBase = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.416, blue: 0.443, opacity: 1),
        dark: Color(red: 0.306, green: 0.600, blue: 0.639, opacity: 1)
    )
    static let accentBgSubtle = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.416, blue: 0.443, opacity: 0.055),
        dark: Color(red: 0.306, green: 0.600, blue: 0.639, opacity: 0.055)
    )
    static let accentBorderHeavy = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.416, blue: 0.443, opacity: 1),
        dark: Color(red: 0.306, green: 0.600, blue: 0.639, opacity: 1)
    )
    static let accentBorderSubtle = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.416, blue: 0.443, opacity: 0.125),
        dark: Color(red: 0.306, green: 0.600, blue: 0.639, opacity: 0.125)
    )

    // -- Positive (Garuda / Green) --
    static let positiveFgPrimary = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.420, blue: 0.114, opacity: 1),
        dark: Color(red: 0.325, green: 0.620, blue: 0.333, opacity: 1)
    )
    static let positiveFgSecondary = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.420, blue: 0.114, opacity: 0.65),
        dark: Color(red: 0.325, green: 0.620, blue: 0.333, opacity: 0.65)
    )
    static let positiveBgBase = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.420, blue: 0.114, opacity: 1),
        dark: Color(red: 0.325, green: 0.620, blue: 0.333, opacity: 1)
    )
    static let positiveBgSubtle = Color.dynamicColor(
        light: Color(red: 0.004, green: 0.420, blue: 0.114, opacity: 0.055),
        dark: Color(red: 0.325, green: 0.620, blue: 0.333, opacity: 0.055)
    )

    // -- Negative (Ifrit / Red) --
    static let negativeFgPrimary = Color.dynamicColor(
        light: Color(red: 0.635, green: 0.208, blue: 0.267, opacity: 1),
        dark: Color(red: 0.863, green: 0.412, blue: 0.451, opacity: 1)
    )
    static let negativeFgSecondary = Color.dynamicColor(
        light: Color(red: 0.635, green: 0.208, blue: 0.267, opacity: 0.65),
        dark: Color(red: 0.863, green: 0.412, blue: 0.451, opacity: 0.65)
    )
    static let negativeBgBase = Color.dynamicColor(
        light: Color(red: 0.635, green: 0.208, blue: 0.267, opacity: 1),
        dark: Color(red: 0.863, green: 0.412, blue: 0.451, opacity: 1)
    )
    static let negativeBgSubtle = Color.dynamicColor(
        light: Color(red: 0.635, green: 0.208, blue: 0.267, opacity: 0.055),
        dark: Color(red: 0.863, green: 0.412, blue: 0.451, opacity: 0.055)
    )

    // -- Warning (Phoenix / Orange) --
    static let warningFgPrimary = Color.dynamicColor(
        light: Color(red: 0.592, green: 0.263, blue: 0.102, opacity: 1),
        dark: Color(red: 0.835, green: 0.443, blue: 0.255, opacity: 1)
    )
    static let warningFgSecondary = Color.dynamicColor(
        light: Color(red: 0.592, green: 0.263, blue: 0.102, opacity: 0.65),
        dark: Color(red: 0.835, green: 0.443, blue: 0.255, opacity: 0.65)
    )
    static let warningBgBase = Color.dynamicColor(
        light: Color(red: 0.592, green: 0.263, blue: 0.102, opacity: 1),
        dark: Color(red: 0.835, green: 0.443, blue: 0.255, opacity: 1)
    )
    static let warningBgSubtle = Color.dynamicColor(
        light: Color(red: 0.592, green: 0.263, blue: 0.102, opacity: 0.055),
        dark: Color(red: 0.835, green: 0.443, blue: 0.255, opacity: 0.055)
    )
}
