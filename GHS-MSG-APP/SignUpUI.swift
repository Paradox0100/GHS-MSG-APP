//
//  SignUpUI.swift
//  GHS-MSG-APP
//
//  Created by Everett Hurder on 6/1/26.
//

// TODO: add the backend

import SwiftUI

struct SignUpUI: View {
    private enum AuthMode: String, CaseIterable {
        case signIn = "Log In"
        case signUp = "Sign Up"
    }

    @State private var authMode: AuthMode = .signIn
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var rememberMe = true
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var errorMessage: String?

    private var isSignUp: Bool {
        authMode == .signUp
    }

    private var primaryButtonTitle: String {
        isSignUp ? "Create Account" : "Log In"
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {
                    header
                    authCard
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 36)
                .frame(maxWidth: 680)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.27, green: 0.02, blue: 0.08),
                Color(red: 0.48, green: 0.05, blue: 0.14),
                Color(red: 0.70, green: 0.12, blue: 0.22)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var header: some View {
        VStack(spacing: 10) {
            Text("Ram Chat")
                .font(.system(size: 58, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.72)

            Text("Sign in with your school email to stay connected.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.84))
                .multilineTextAlignment(.center)
        }
    }

    private var authCard: some View {
        VStack(spacing: 28) {
            Picker("Authentication Mode", selection: $authMode) {
                ForEach(AuthMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)

            VStack(spacing: 18) {
                inputField(
                    title: "Email",
                    text: $email,
                    systemImage: "envelope.fill",
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                passwordField(
                    title: "Password",
                    text: $password,
                    isVisible: $showPassword,
                    textContentType: isSignUp ? .newPassword : .password
                )

                if isSignUp {
                    passwordField(
                        title: "Confirm Password",
                        text: $confirmPassword,
                        isVisible: $showConfirmPassword,
                        textContentType: .newPassword
                    )
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }

            optionsRow

            if let errorMessage {
                Label(errorMessage, systemImage: "exclamationmark.circle.fill")
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(Color(red: 0.72, green: 0.13, blue: 0.12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.opacity)
            }

            Button(action: authenticate) {
                HStack(spacing: 10) {
                    Text(primaryButtonTitle)
                    Image(systemName: "arrow.right")
                        .font(.headline)
                }
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 62)
                .background(Color(red: 0.48, green: 0.05, blue: 0.14), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            .buttonStyle(.plain)

            Button(action: toggleMode) {
                Text(isSignUp ? "Already have an account? Log in" : "Need an account? Sign up")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color(red: 0.48, green: 0.05, blue: 0.14))
            }
            .buttonStyle(.plain)
        }
        .padding(40)
        .frame(minHeight: 500)
        .background(.white, in: RoundedRectangle(cornerRadius: 32, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(.white.opacity(0.75), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.24), radius: 34, x: 0, y: 22)
        .animation(.snappy, value: authMode)
    }

    private var optionsRow: some View {
        HStack {
            Button {
                rememberMe.toggle()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color(red: 0.48, green: 0.05, blue: 0.14))

                    Text("Remember me")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Remember me")
            .accessibilityValue(rememberMe ? "On" : "Off")

            Spacer()

            Button("Forgot password?") {
                errorMessage = "Password reset is not connected yet."
            }
            .font(.footnote.weight(.semibold))
            .foregroundStyle(Color(red: 0.48, green: 0.05, blue: 0.14))
        }
    }

    private func inputField(
        title: String,
        text: Binding<String>,
        systemImage: String,
        keyboardType: UIKeyboardType,
        textContentType: UITextContentType
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(Color(red: 0.48, green: 0.05, blue: 0.14))
                .frame(width: 22)

            TextField(title, text: text)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .submitLabel(.next)
        }
        .padding(.horizontal, 16)
        .frame(height: 62)
        .background(Color(red: 0.98, green: 0.96, blue: 0.97), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color(red: 0.48, green: 0.05, blue: 0.14).opacity(0.16), lineWidth: 1)
        }
    }

    private func passwordField(
        title: String,
        text: Binding<String>,
        isVisible: Binding<Bool>,
        textContentType: UITextContentType
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .foregroundStyle(Color(red: 0.48, green: 0.05, blue: 0.14))
                .frame(width: 22)

            Group {
                if isVisible.wrappedValue {
                    TextField(title, text: text)
                } else {
                    SecureField(title, text: text)
                }
            }
            .textContentType(textContentType)
            .submitLabel(.done)

            Button {
                isVisible.wrappedValue.toggle()
            } label: {
                Image(systemName: isVisible.wrappedValue ? "eye.slash.fill" : "eye.fill")
                    .foregroundStyle(.secondary)
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isVisible.wrappedValue ? "Hide password" : "Show password")
        }
        .padding(.horizontal, 16)
        .frame(height: 62)
        .background(Color(red: 0.98, green: 0.96, blue: 0.97), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color(red: 0.48, green: 0.05, blue: 0.14).opacity(0.16), lineWidth: 1)
        }
    }

    private func toggleMode() {
        withAnimation(.snappy) {
            authMode = isSignUp ? .signIn : .signUp
            errorMessage = nil
            confirmPassword = ""
        }
    }

    private func authenticate() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmedEmail.contains("@"), trimmedEmail.contains(".") else {
            errorMessage = "Enter a valid email address."
            return
        }

        guard password.count >= 8 else {
            errorMessage = "Password must be at least 8 characters."
            return
        }

        if isSignUp, password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }

        errorMessage = nil
    }
}

#Preview {
    SignUpUI()
}
