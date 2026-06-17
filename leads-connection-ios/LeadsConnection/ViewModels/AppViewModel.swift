import SwiftUI

let MOCK_USER = User(
    firstName: "John",
    lastName: "Doe",
    email: "john.doe@example.com",
    company: "Doe Solutions",
    type: "Service Provider",
    stats: UserStats(newLeads: 12, completed: 48, inProgress: 6)
)

let MOCK_LEADS: [Lead] = [
    Lead(id: "1", title: "Plumbing Repair Needed", description: "Need an experienced plumber to fix leaking pipes and install new bathroom fixtures for a residential property in Sandton.", budget: 8500, location: "Sandton", province: "Gauteng", category: "PLUMBING", type: "Service", status: "Open", priority: "High", isUrgent: true, createdAt: "2026-06-10", views: 45, applications: 3, company: "Sandton Residences", contactEmail: "admin@sandtonres.co.za", contactPhone: "+27 11 234 5678", tags: ["plumbing", "bathroom", "residential"]),
    Lead(id: "2", title: "Website for Restaurant", description: "Looking for a web developer to build a modern website for our new restaurant with online ordering and reservation system.", budget: 25000, location: "Cape Town", province: "Western Cape", category: "RESTAURANT", type: "Project", status: "Open", priority: "Medium", isUrgent: false, createdAt: "2026-06-09", views: 78, applications: 5, company: "Bistro Français", contactEmail: "info@bistrofr.co.za", contactPhone: "+27 21 345 6789", tags: ["web", "restaurant", "online-ordering"]),
    Lead(id: "3", title: "Electrical Wiring for Office", description: "Commercial electrician needed to rewire entire office floor, install new lighting and backup generator connection.", budget: 45000, location: "Midrand", province: "Gauteng", category: "ELECTRICAL", type: "Service", status: "In Progress", priority: "High", isUrgent: true, createdAt: "2026-06-08", views: 34, applications: 2, company: "TechPark Offices", contactEmail: "facilities@techpark.co.za", contactPhone: "+27 11 456 7890", tags: ["electrical", "commercial", "wiring"]),
    Lead(id: "4", title: "Business Partnership Opportunity", description: "Seeking a business partner with experience in retail to help launch and co-manage a new clothing line in Johannesburg.", budget: 150000, location: "Johannesburg", province: "Gauteng", category: "BUSINESS", type: "Partnership", status: "Open", priority: "Low", isUrgent: false, createdAt: "2026-06-07", views: 92, applications: 7, company: "Urban Threads", contactEmail: "info@urbanthreads.co.za", contactPhone: "+27 11 567 8901", tags: ["partnership", "retail", "clothing"]),
    Lead(id: "5", title: "Funding for Construction Project", description: "Need investors or funding partners for a mixed-use residential and commercial development in Sandton CBD.", budget: 5000000, location: "Sandton", province: "Gauteng", category: "FUNDING", type: "Investment", status: "Open", priority: "Urgent", isUrgent: true, createdAt: "2026-06-06", views: 156, applications: 1, company: "Skyline Developments", contactEmail: "info@skylinedev.co.za", contactPhone: "+27 11 678 9012", tags: ["funding", "construction", "development"]),
    Lead(id: "6", title: "Carpentry Work in Soweto", description: "Skilled carpenter required for custom kitchen cabinets, built-in wardrobes and wooden deck installation.", budget: 18000, location: "Soweto", province: "Gauteng", category: "CARPENTRY", type: "Service", status: "Open", priority: "Medium", isUrgent: false, createdAt: "2026-06-05", views: 28, applications: 4, company: "Mthembu Family", contactEmail: "mthembu@email.co.za", contactPhone: "+27 11 789 0123", tags: ["carpentry", "kitchen", "custom"]),
    Lead(id: "7", title: "Landscaping for Durban Estate", description: "Full garden landscaping including irrigation system, indigenous plants, paving and outdoor lighting for a private estate.", budget: 35000, location: "Durban", province: "KwaZulu-Natal", category: "LANDSCAPING", type: "Project", status: "Open", priority: "Low", isUrgent: false, createdAt: "2026-06-04", views: 41, applications: 6, company: "Seaside Estate", contactEmail: "estate@seaside.co.za", contactPhone: "+27 31 234 5678", tags: ["landscaping", "garden", "irrigation"]),
    Lead(id: "8", title: "Security System for Springs Warehouse", description: "Need a complete security solution including CCTV cameras, alarm system and access control for a large warehouse.", budget: 55000, location: "Springs", province: "Gauteng", category: "SECURITY", type: "Project", status: "Open", priority: "High", isUrgent: true, createdAt: "2026-06-03", views: 63, applications: 3, company: "Springs Logistics", contactEmail: "security@springslog.co.za", contactPhone: "+27 11 345 6789", tags: ["security", "cctv", "warehouse"]),
    Lead(id: "9", title: "IT Support for Pretoria Firm", description: "Ongoing IT support contract needed for a 50-person law firm including network maintenance, helpdesk and cloud migration.", budget: 12000, location: "Pretoria", province: "Gauteng", category: "IT_SERVICES", type: "Contract", status: "In Progress", priority: "Medium", isUrgent: false, createdAt: "2026-06-02", views: 55, applications: 8, company: "Van der Merwe Attorneys", contactEmail: "it@vdmattorneys.co.za", contactPhone: "+27 12 456 7890", tags: ["it-support", "network", "cloud"]),
    Lead(id: "10", title: "Transport Services for Mining Operation", description: "Looking for a logistics company to handle transport of equipment and materials to a mining site in the Northern Cape.", budget: 75000, location: "Kathu", province: "Northern Cape", category: "TRANSPORT", type: "Contract", status: "Open", priority: "High", isUrgent: false, createdAt: "2026-06-01", views: 87, applications: 2, company: "Northern Mining Corp", contactEmail: "procurement@nmc.co.za", contactPhone: "+27 53 567 8901", tags: ["transport", "mining", "logistics"])
]

let MOCK_ADS: [AdCreative] = [
    AdCreative(advertiser: "BuildPro Tools", headline: "Professional Tools for Every Trade", body: "Get 20% off on all power tools. Quality you can trust.", cta: "Shop Now", color: "F59E0B"),
    AdCreative(advertiser: "Swift Finance", headline: "Fast Business Funding", body: "Get approved in 24 hours. Rates from 12% p.a.", cta: "Apply Now", color: "06B6D4"),
    AdCreative(advertiser: "LeadGenius CRM", headline: "Manage Your Leads Smarter", body: "Track, nurture and close more deals with LeadGenius.", cta: "Start Free Trial", color: "7C3AED"),
    AdCreative(advertiser: "SafeSite Insurance", headline: "Insured for Success", body: "Comprehensive coverage for service providers. Get a quote.", cta: "Get Quote", color: "10B981"),
    AdCreative(advertiser: "TruckIt Logistics", headline: "Nationwide Delivery Service", body: "Reliable same-day delivery across all provinces.", cta: "Book Now", color: "EF4444")
]

@MainActor
class AppViewModel: ObservableObject {
    @Published var leads: [Lead] = MOCK_LEADS
    @Published var currentUser: User?
    @Published var savedLeadIds: Set<String> = []
    @Published var applications: [LeadApplication] = []
    @Published var selectedCategory: String? = nil
    @Published var searchQuery: String = ""
    @Published var leadViewCount: Int = 0
    @Published var showingAd: Bool = false
    @Published var currentAd: AdCreative? = nil
    @Published var adDismissable: Bool = false
    @Published var navigationPath = NavigationPath()
    @Published var isLoggedIn: Bool = false

    @AppStorage("savedLeadIdsData") private var savedLeadIdsData: Data = Data()
    @AppStorage("currentUserData") private var currentUserData: Data = Data()
    @AppStorage("applicationsData") private var applicationsData: Data = Data()

    private var nextLeadId: Int = 11
    private var lastAdIndex: Int = -1

    init() {
        loadPersistedData()
        currentUser = MOCK_USER
    }

    private func loadPersistedData() {
        if let ids = try? JSONDecoder().decode([String].self, from: savedLeadIdsData) {
            savedLeadIds = Set(ids)
        }
        if let user = try? JSONDecoder().decode(User.self, from: currentUserData) {
            currentUser = user
            isLoggedIn = true
        }
        if let apps = try? JSONDecoder().decode([LeadApplication].self, from: applicationsData) {
            applications = apps
        }
    }

    private func persistSavedIds() {
        savedLeadIdsData = (try? JSONEncoder().encode(Array(savedLeadIds))) ?? Data()
    }

    private func persistCurrentUser() {
        currentUserData = (try? JSONEncoder().encode(currentUser)) ?? Data()
    }

    private func persistApplications() {
        applicationsData = (try? JSONEncoder().encode(applications)) ?? Data()
    }

    func login(email: String, password: String) -> Bool {
        guard !email.isEmpty, !password.isEmpty else { return false }
        currentUser = MOCK_USER
        isLoggedIn = true
        persistCurrentUser()
        return true
    }

    func signup(firstName: String, lastName: String, email: String, company: String, password: String) -> Bool {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else { return false }
        currentUser = User(
            firstName: firstName,
            lastName: lastName,
            email: email,
            company: company,
            type: "Service Provider",
            stats: UserStats(newLeads: 0, completed: 0, inProgress: 0)
        )
        isLoggedIn = true
        persistCurrentUser()
        return true
    }

    func logout() {
        currentUser = nil
        isLoggedIn = false
        currentUserData = Data()
    }

    func createLead(title: String, description: String, budget: Double, location: String, province: String, category: String, type: String, priority: String, email: String, phone: String, company: String, tags: [String]) -> Lead {
        let id = "\(nextLeadId)"
        nextLeadId += 1
        let now = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let lead = Lead(
            id: id,
            title: title,
            description: description,
            budget: budget,
            location: location,
            province: province,
            category: category,
            type: type,
            status: "Open",
            priority: priority,
            isUrgent: priority == "Urgent",
            createdAt: df.string(from: now),
            views: 0,
            applications: 0,
            company: company,
            contactEmail: email,
            contactPhone: phone,
            tags: tags
        )
        leads.insert(lead, at: 0)
        return lead
    }

    func updateLead(id: String, title: String, description: String, budget: Double, location: String, province: String, category: String, type: String, status: String, priority: String, email: String, phone: String, company: String, tags: [String]) {
        guard let index = leads.firstIndex(where: { $0.id == id }) else { return }
        leads[index].title = title
        leads[index].description = description
        leads[index].budget = budget
        leads[index].location = location
        leads[index].province = province
        leads[index].category = category
        leads[index].type = type
        leads[index].status = status
        leads[index].priority = priority
        leads[index].isUrgent = priority == "Urgent"
        leads[index].contactEmail = email
        leads[index].contactPhone = phone
        leads[index].company = company
        leads[index].tags = tags
    }

    func deleteLead(id: String) {
        leads.removeAll { $0.id == id }
        savedLeadIds.remove(id)
        persistSavedIds()
        applications.removeAll { $0.leadId == id }
        persistApplications()
    }

    func saveLead(_ id: String) {
        savedLeadIds.insert(id)
        persistSavedIds()
    }

    func unsaveLead(_ id: String) {
        savedLeadIds.remove(id)
        persistSavedIds()
    }

    func isLeadSaved(_ id: String) -> Bool {
        savedLeadIds.contains(id)
    }

    func getSavedLeads() -> [Lead] {
        leads.filter { savedLeadIds.contains($0.id) }
    }

    func applyToLead(_ leadId: String) {
        guard !hasApplied(leadId) else { return }
        let app = LeadApplication(id: UUID().uuidString, leadId: leadId, status: "PENDING", appliedAt: Date())
        applications.append(app)
        persistApplications()
        if let index = leads.firstIndex(where: { $0.id == leadId }) {
            leads[index].applications += 1
        }
    }

    func hasApplied(_ leadId: String) -> Bool {
        applications.contains { $0.leadId == leadId }
    }

    func getMyApplications() -> [LeadApplication] {
        applications
    }

    func updateProfile(firstName: String, lastName: String, email: String, company: String, type: String) {
        currentUser?.firstName = firstName
        currentUser?.lastName = lastName
        currentUser?.email = email
        currentUser?.company = company
        currentUser?.type = type
        persistCurrentUser()
    }

    func recordLeadView() -> Bool {
        leadViewCount += 1
        if leadViewCount % 3 == 0 {
            currentAd = pickAd()
            showingAd = true
            adDismissable = false
            return true
        }
        return false
    }

    func pickAd() -> AdCreative {
        var index: Int
        repeat {
            index = Int.random(in: 0..<MOCK_ADS.count)
        } while index == lastAdIndex && MOCK_ADS.count > 1
        lastAdIndex = index
        return MOCK_ADS[index]
    }

    func formatMoney(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ZAR"
        formatter.currencySymbol = "R"
        formatter.groupingSize = 3
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "R0"
    }

    func formatDate(_ dateString: String) -> String {
        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd"
        guard let date = input.date(from: dateString) else { return dateString }
        let output = DateFormatter()
        output.dateFormat = "dd MMM yyyy"
        return output.string(from: date)
    }
}

extension String: Identifiable {
    public var id: String { self }
}
