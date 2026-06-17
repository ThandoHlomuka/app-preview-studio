import SwiftUI

struct PostLeadView: View {
    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var budget: Double = 10000
    @State private var priority: String = "Medium"
    @State private var location: String = ""
    @State private var province: String = "Gauteng"
    @State private var category: String = "PLUMBING"
    @State private var type: String = "Service"
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var company: String = ""
    @State private var tagsText: String = ""
    @State private var errorMessage: String?

    private let provinces = ["Gauteng", "Western Cape", "KwaZulu-Natal", "Eastern Cape", "Northern Cape", "Free State", "Limpopo", "Mpumalanga", "North West"]
    private let categories = ["PLUMBING", "IT_SERVICES", "ELECTRICAL", "BUSINESS", "FUNDING", "CARPENTRY", "LANDSCAPING", "SECURITY", "TRANSPORT", "MINING", "CONSTRUCTION", "RESTAURANT"]
    private let types = ["Service", "Project", "Contract", "Partnership", "Investment"]
    private let priorities = ["Low", "Medium", "High", "Urgent"]

    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                title: "Post a Lead",
                showBack: true,
                onBack: { dismiss() }
            )

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    FieldLabel("Title *")
                    GlassTextField(icon: "textformat", placeholder: "e.g. Plumbing Repair Needed", text: $title)

                    FieldLabel("Description *")
                    ZStack(alignment: .topLeading) {
                        if description.isEmpty {
                            Text("Describe the work needed...")
                                .font(AppTheme.bodyFont(size: 14))
                                .foregroundColor(.themeTextMuted)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                        }
                        TextEditor(text: $description)
                            .font(AppTheme.bodyFont(size: 14))
                            .foregroundColor(.themeTextPrimary)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .frame(minHeight: 100)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.themeSurfaceGlass)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.themeBorder, lineWidth: 0.5)
                            )
                    )

                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Budget (ZAR)")
                            HStack {
                                Text("R")
                                    .foregroundColor(.themeTextMuted)
                                TextField("Amount", value: $budget, format: .number)
                                    .font(AppTheme.bodyFont(size: 14))
                                    .foregroundColor(.themeTextPrimary)
                                    .keyboardType(.numberPad)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.themeSurfaceGlass)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.themeBorder, lineWidth: 0.5)
                                    )
                            )
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Priority")
                            Picker("Priority", selection: $priority) {
                                ForEach(priorities, id: \.self) { p in
                                    Text(p).tag(p)
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
                        }
                    }

                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Location")
                            GlassTextField(icon: "mappin", placeholder: "e.g. Sandton", text: $location)
                        }
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Province")
                            Picker("Province", selection: $province) {
                                ForEach(provinces, id: \.self) { p in
                                    Text(p).tag(p)
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
                        }
                    }

                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Category")
                            Picker("Category", selection: $category) {
                                ForEach(categories, id: \.self) { c in
                                    Text(c.replacingOccurrences(of: "_", with: " ")).tag(c)
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
                        }
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Type")
                            Picker("Type", selection: $type) {
                                ForEach(types, id: \.self) { t in
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
                        }
                    }

                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Contact Email")
                            GlassTextField(icon: "envelope", placeholder: "email@example.com", text: $email)
                        }
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel("Contact Phone")
                            GlassTextField(icon: "phone", placeholder: "+27 XX XXX XXXX", text: $phone)
                        }
                    }

                    FieldLabel("Company")
                    GlassTextField(icon: "building", placeholder: "Your company name", text: $company)

                    FieldLabel("Tags (comma separated)")
                    GlassTextField(icon: "tag", placeholder: "e.g. plumbing, residential, urgent", text: $tagsText)

                    if let error = errorMessage {
                        Text(error)
                            .font(AppTheme.captionFont(size: 12))
                            .foregroundColor(.themeError)
                    }

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
                            submitLead()
                        } label: {
                            Text("Post Lead")
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
    }

    private func submitLead() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Title is required"
            return
        }
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Description is required"
            return
        }
        let tags = tagsText
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        _ = appVM.createLead(
            title: title,
            description: description,
            budget: budget,
            location: location.isEmpty ? "Johannesburg" : location,
            province: province,
            category: category,
            type: type,
            priority: priority,
            email: email,
            phone: phone,
            company: company,
            tags: tags
        )
        dismiss()
    }
}

struct FieldLabel: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(AppTheme.captionFont(size: 11))
            .foregroundColor(.themeTextSecondary)
            .textCase(.uppercase)
    }
}
