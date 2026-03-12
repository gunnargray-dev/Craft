import SwiftUI

enum TextFieldState: String, CaseIterable, Identifiable {
    case `default` = "Default"
    case focused = "Focused"
    case filled = "Filled"
    case error = "Error"
    case disabled = "Disabled"

    var id: String { rawValue }

    var borderColor: Color {
        switch self {
        case .default: Color.borderBase
        case .focused: .accentFgPrimary
        case .filled: Color.borderBase
        case .error: .negativeFgPrimary
        case .disabled: Color.borderBase.opacity(0.5)
        }
    }

    var borderWidth: CGFloat {
        switch self {
        case .focused, .error: 2
        default: 1
        }
    }

    var backgroundColor: Color {
        switch self {
        case .disabled: Color.bgSoft
        default: Color.bgRaised
        }
    }

    var helperText: String? {
        switch self {
        case .default: "Helper text goes here"
        case .focused: "Type something..."
        case .filled: "Looking good!"
        case .error: "This field is required"
        case .disabled: "This field is disabled"
        }
    }

    var helperColor: Color {
        switch self {
        case .error: .negativeFgPrimary
        default: Color.fgSecondary
        }
    }

    var sfSymbol: String {
        switch self {
        case .default: "minus.circle"
        case .focused: "pencil.circle.fill"
        case .filled: "checkmark.circle.fill"
        case .error: "exclamationmark.circle.fill"
        case .disabled: "lock.circle.fill"
        }
    }
}

struct TextInputDemoView: View {
    @State private var selectedState: TextFieldState = .default
    @State private var textValue = ""
    @FocusState private var isFieldFocused: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - State Picker
                Text("Field State")
                    .sectionHeader()
                    .enterAnimation(delay: 0.0)

                Picker("State", selection: $selectedState) {
                    ForEach(TextFieldState.allCases) { state in
                        Text(state.rawValue).tag(state)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.05)

                // MARK: - Live Demo
                Text("Live Preview")
                    .sectionHeader()
                    .enterAnimation(delay: 0.1)

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Email Address")
                        .font(PPFont.bodyMdStrong)
                        .foregroundStyle(selectedState == .disabled ? Color.fgTertiary : Color.fgPrimary)

                    HStack(spacing: Spacing.sm) {
                        Image(systemName: "envelope")
                            .foregroundStyle(iconColor)
                            .frame(width: 20)

                        TextField(
                            placeholderText,
                            text: displayText
                        )
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused($isFieldFocused)
                        .disabled(selectedState == .disabled)

                        if selectedState == .filled || selectedState == .error {
                            Image(systemName: selectedState == .filled ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                .foregroundStyle(selectedState == .filled ? Color.positiveFgPrimary : Color.negativeFgPrimary)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.sm)
                    .frame(minHeight: 48)
                    .background(selectedState.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                            .strokeBorder(selectedState.borderColor, lineWidth: selectedState.borderWidth)
                    )
                    .animation(reduceMotion ? .default : Springs.snappy, value: selectedState)

                    if let helper = selectedState.helperText {
                        HStack(spacing: Spacing.xxs) {
                            if selectedState == .error {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(PPFont.caption)
                            }
                            Text(helper)
                                .font(PPFont.caption)
                        }
                        .foregroundStyle(selectedState.helperColor)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(reduceMotion ? .default : Springs.snappy, value: selectedState)
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.15)

                // MARK: - All States Reference
                Text("All States")
                    .sectionHeader()
                    .enterAnimation(delay: 0.25)

                VStack(spacing: Spacing.md) {
                    ForEach(Array(TextFieldState.allCases.enumerated()), id: \.element.id) { index, state in
                        statePreviewRow(state: state)
                            .enterAnimation(delay: 0.3 + 0.06 * Double(index))
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)

                // MARK: - Multi-line
                Text("Multi-line Input")
                    .sectionHeader()
                    .enterAnimation(delay: 0.65)

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Description")
                        .font(PPFont.bodyMdStrong)

                    TextEditor(text: .constant("This is a multi-line text editor that grows with content. It uses the same styling tokens for consistency."))
                        .font(PPFont.bodyLg)
                        .frame(minHeight: 100)
                        .scrollContentBackground(.hidden)
                        .padding(Spacing.sm)
                        .background(Color.bgRaised)
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                                .strokeBorder(Color.borderBase, lineWidth: 1)
                        )

                    Text("0 / 500 characters")
                        .font(PPFont.caption)
                        .foregroundStyle(Color.fgSecondary)
                }
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.7)

                Spacer(minLength: Spacing.xxl)
            }
        }
        .background(Color.bgBase)
        .navigationTitle("Text Inputs")
        .onChange(of: selectedState) {
            switch selectedState {
            case .focused:
                isFieldFocused = true
            case .filled:
                isFieldFocused = false
                textValue = "user@example.com"
            case .error:
                isFieldFocused = false
                textValue = "invalid"
            case .disabled, .default:
                isFieldFocused = false
                textValue = ""
            }
        }
    }

    private var placeholderText: String {
        switch selectedState {
        case .error: "Enter a valid email"
        default: "you@example.com"
        }
    }

    private var displayText: Binding<String> {
        switch selectedState {
        case .filled:
            .constant("user@example.com")
        case .error:
            .constant("invalid")
        case .disabled:
            .constant("")
        default:
            $textValue
        }
    }

    private var iconColor: Color {
        switch selectedState {
        case .focused: .accentFgPrimary
        case .error: .negativeFgPrimary
        case .disabled: Color.fgTertiary
        default: Color.fgSecondary
        }
    }

    @ViewBuilder
    private func statePreviewRow(state: TextFieldState) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: state.sfSymbol)
                    .foregroundStyle(state == .error ? Color.negativeFgPrimary : state == .filled ? Color.positiveFgPrimary : Color.fgSecondary)
                Text(state.rawValue)
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
            }

            HStack(spacing: Spacing.sm) {
                Image(systemName: "envelope")
                    .foregroundStyle(state == .disabled ? Color.fgTertiary : Color.fgSecondary)
                    .frame(width: 20)

                Text(state == .filled ? "user@example.com" : state == .error ? "invalid" : "you@example.com")
                    .font(PPFont.bodyLg)
                    .foregroundStyle(
                        state == .disabled ? Color.fgTertiary :
                        (state == .default ? Color.fgTertiary : Color.fgPrimary)
                    )

                Spacer()

                if state == .filled {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.positiveFgPrimary)
                }
                if state == .error {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundStyle(Color.negativeFgPrimary)
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .frame(minHeight: 48)
            .background(state.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                    .strokeBorder(state.borderColor, lineWidth: state.borderWidth)
            )
        }
    }
}

#Preview {
    NavigationStack {
        TextInputDemoView()
    }
}
