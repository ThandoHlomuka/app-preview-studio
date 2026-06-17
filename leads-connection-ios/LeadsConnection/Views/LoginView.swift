import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignup: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 60)

                ZStack {
                    Circle()
                        .fill(AppTheme.primaryGradient)
                        .frame(width: 80, height: 80)
                    Image(systemName: "shield.checkered")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                }

                Text("Leads Connection")
                    .font(AppTheme.titleFont(size: 32))
                    .overlay(AppTheme.primaryGradient)
                    .mask(Text("Leads Connection").font(AppTheme.titleFont(size: 32)))

                Text("Find the right leads for your business")
                    .font(AppTheme.bodyFont(size: 14))
                    .foregroundColor(.themeTextMuted)

                VStack(spacing: 16) {
                    GlassTextField(icon: "envelope.fill", placeholder: "Email", text: $email)
                    GlassTextField(icon: "lock.fill", placeholder: "Password", text: $password, isSecure: true)
                }
                .padding(.horizontal, 24)

                if let error = errorMessage {
                    Text(error)
                        .font(AppTheme.captionFont(size: 12))
                        .foregroundColor(.themeError)
                }

                Button {
                    if appVM.login(email: email, password: password) {
                        errorMessage = nil
                    } else {
                        errorMessage = "Please enter email and password"
                    }
                } label: {
                    Text("Login")
                        .font(AppTheme.bodyFont(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppTheme.primaryGradient)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)

                Button {
                    showSignup = true
                } label: {
                    Text("Don't have an account? Sign Up")
                        .font(AppTheme.bodyFont(size: 13))
                        .foregroundColor(.themePrimaryLight)
                }

                Spacer()
            }
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .sheet(isPresented: $showSignup) {
            SignupView()
        }
    }
}

struct GlassTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.themeTextMuted)
                .frame(width: 20)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(AppTheme.bodyFont(size: 15))
                    .foregroundColor(.themeTextPrimary)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .font(AppTheme.bodyFont(size: 15))
                    .foregroundColor(.themeTextPrimary)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.themeSurfaceGlass)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.themeBorder, lineWidth: 0.5)
                )
        )
    }
}
