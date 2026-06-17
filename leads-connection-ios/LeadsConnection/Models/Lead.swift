import Foundation

struct Lead: Identifiable, Codable {
    let id: String
    var title: String
    var description: String
    var budget: Double
    var location: String
    var province: String
    var category: String
    var type: String
    var status: String
    var priority: String
    var isUrgent: Bool
    var createdAt: String
    var views: Int
    var applications: Int
    var company: String
    var contactEmail: String
    var contactPhone: String
    var tags: [String]
}

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var company: String
    var type: String
    var stats: UserStats
}

struct UserStats: Codable {
    var newLeads: Int
    var completed: Int
    var inProgress: Int
}

struct LeadApplication: Identifiable, Codable {
    let id: String
    let leadId: String
    var status: String
    let appliedAt: Date
}

struct AdCreative: Identifiable {
    let id = UUID()
    let advertiser: String
    let headline: String
    let body: String
    let cta: String
    let color: String
}

enum LeadCategory: String, CaseIterable {
    case all = "All"
    case plumbing = "PLUMBING"
    case it_services = "IT_SERVICES"
    case electrical = "ELECTRICAL"
    case business = "BUSINESS"
    case funding = "FUNDING"
    case carpentry = "CARPENTRY"
    case landscaping = "LANDSCAPING"
    case security = "SECURITY"
    case transport = "TRANSPORT"
    case mining = "MINING"
    case construction = "CONSTRUCTION"
    case restaurant = "RESTAURANT"
}

enum LeadStatus: String, Codable {
    case open = "Open"
    case inProgress = "In Progress"
    case completed = "Completed"
    case closed = "Closed"
}

enum LeadPriority: String, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case urgent = "Urgent"
}

enum ApplicationStatus: String, Codable {
    case pending = "PENDING"
    case accepted = "ACCEPTED"
    case rejected = "REJECTED"
}
