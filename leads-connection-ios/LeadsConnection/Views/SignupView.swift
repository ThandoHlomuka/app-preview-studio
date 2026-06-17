import SwiftUI

struct SignupView: View {
    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.dismiss) var dismiss
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var company: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 40)

                ZStack {
                    Circle()
                        .fill(AppTheme.primaryGradient)
                        .frame(width: 72, height: 72)
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                }

                Text("Create Account")
                    .font(AppTheme.titleFont(size: 28))
                    .overlay(AppTheme.primaryGradient)
                    .mask(Text("Create Account").font(AppTheme.titleFont(size: 28)))

                Text("Join Leads Connection today")
                    .font(AppTheme.bodyFont(size: 14))
                    .foregroundColor(.themeTextMuted)

                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        GlassTextField(icon: "person.fill", placeholder: "First Name", text: $firstName)
                        GlassTextField(icon: "person.fill", placeholder: "Last Name", text: $lastName)
                    }
                    GlassTextField(icon: "building.fill", placeholder: "Company (Optional)", text: $company)
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
                    if appVM.signup(firstName: firstName, lastName: lastName, email: email, company: company, password: password) {
                        errorMessage = nil
                        dismiss()
                    } else {
                        errorMessage = "Please fill in all required fields"
                    }
                } label: {
                    Text("Sign Up")
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
                    dismiss()
                } label: {
                    Text("Already have an account? Login")
                        .font(AppTheme.bodyFont(size: 13))
                        .foregroundColor(.themePrimaryLight)
                }

                Spacer()
            }
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
    }
}
