import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.dismiss) var dismiss

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var company: String = ""
    @State private var accountType: String = "Service Provider"

    private let accountTypes = ["Service Provider", "Client", "Partner", "Investor"]

    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                title: "Edit Profile",
                showBack: true,
                onBack: { dismiss() }
            )

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.primaryGradient)
                            .frame(width: 80, height: 80)
                        Image(systemName: "camera.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 8)

                    FieldLabel("First Name")
                    GlassTextField(icon: "person.fill", placeholder: "First Name", text: $firstName)

                    FieldLabel("Last Name")
                    GlassTextField(icon: "person.fill", placeholder: "Last Name", text: $lastName)

                    FieldLabel("Email")
                    GlassTextField(icon: "envelope.fill", placeholder: "Email", text: $email)

                    FieldLabel("Company")
                    GlassTextField(icon: "building.fill", placeholder: "Company", text: $company)

                    FieldLabel("Account Type")
                    Picker("Account Type", selection: $accountType) {
                        ForEach(accountTypes, id: \.self) { t in
                            Text(t).tag(t)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.themeTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.themeSurfaceGlass)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.themeBorder, lineWidth: 0.5)
                            )
                    )

                    HStack(spacing: 12) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .font(AppTheme.captionFont(size: 13))
                                .foregroundColor(.themeTextSecondary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.themeBorder, lineWidth: 1)
                                )
                        }

                        Button {
                            appVM.updateProfile(
                                firstName: firstName,
                                lastName: lastName,
                                email: email,
                                company: company,
                                type: accountType
                            )
                            dismiss()
                        } label: {
                            Text("Save")
                                .font(AppTheme.captionFont(size: 13))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(AppTheme.primaryGradient)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(16)
            }
            .background(AppTheme.backgroundGradient.ignoresSafeArea())
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear {
            firstName = appVM.currentUser?.firstName ?? ""
            lastName = appVM.currentUser?.lastName ?? ""
            email = appVM.currentUser?.email ?? ""
            company = appVM.currentUser?.company ?? ""
            accountType = appVM.currentUser?.type ?? "Service Provider"
        }
    }
}
