package com.leadsconnection.data

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue

object LeadsRepository {

    private val initialLeads = listOf(
        Lead(
            id = "1", title = "Professional Plumber Needed - Bathroom Renovation Sandton",
            description = "Looking for an experienced plumber to complete a full bathroom renovation in Sandton. Work includes installing new pipes, fixtures, bathtub, shower, and toilet. Must have valid plumbing license and insurance.",
            budget = 45000.0, location = "Sandton", province = "Gauteng",
            category = "PLUMBING", type = "FIXED_PRICE", status = "OPEN", priority = "HIGH",
            isUrgent = true, createdAt = "2026-06-10T08:00:00Z", views = 234, applications = 8,
            company = "Sandton Estates", contactEmail = "projects@sandtonestates.co.za",
            contactPhone = "+27 11 234 5678", tags = listOf("bathroom", "renovation", "residential")
        ),
        Lead(
            id = "2", title = "Website Developer for Restaurant Booking Platform",
            description = "Need a full-stack developer to build a custom booking and reservation platform for a high-end restaurant in Cape Town. Must have experience with React, Node.js, and payment integration.",
            budget = 85000.0, location = "Cape Town", province = "Western Cape",
            category = "IT_SERVICES", type = "PROJECT", status = "OPEN", priority = "MEDIUM",
            isUrgent = false, createdAt = "2026-06-09T14:30:00Z", views = 189, applications = 12,
            company = "Cape Gourmet Group", contactEmail = "info@capegourmet.co.za",
            contactPhone = "+27 21 987 6543", tags = listOf("web", "react", "booking")
        ),
        Lead(
            id = "3", title = "Electrical Contractor for Office Building",
            description = "Seeking certified electrical contractor for a 5-floor office building in Rosebank. Scope includes wiring, lighting installation, backup generator connection, and fire alarm system.",
            budget = 120000.0, location = "Rosebank", province = "Gauteng",
            category = "ELECTRICAL", type = "TENDER", status = "OPEN", priority = "HIGH",
            isUrgent = true, createdAt = "2026-06-08T11:15:00Z", views = 312, applications = 5,
            company = "Rosebank Business Park", contactEmail = "facilities@rosebankpark.co.za",
            contactPhone = "+27 11 345 6789", tags = listOf("commercial", "office", "electrical")
        ),
        Lead(
            id = "4", title = "Business Partnership Opportunity - Construction Materials Supply",
            description = "Established construction company looking for a reliable partner to supply building materials for multiple ongoing projects across the Western Cape. Long-term contract available.",
            budget = 500000.0, location = "Stellenbosch", province = "Western Cape",
            category = "BUSINESS", type = "CONTRACT", status = "OPEN", priority = "HIGH",
            isUrgent = false, createdAt = "2026-06-07T09:45:00Z", views = 156, applications = 3,
            company = "Cape Builders Inc", contactEmail = "procurement@capebuilders.co.za",
            contactPhone = "+27 21 456 7890", tags = listOf("partnership", "materials", "supply")
        ),
        Lead(
            id = "5", title = "Funding Required for Low-Cost Housing Project",
            description = "NGO seeking investment partner for a low-cost housing development in Soweto. 200 units planned. Need funding for Phase 1 construction. Strong social impact project with government backing.",
            budget = 2500000.0, location = "Soweto", province = "Gauteng",
            category = "BUSINESS", type = "INVESTMENT", status = "OPEN", priority = "URGENT",
            isUrgent = true, createdAt = "2026-06-06T16:20:00Z", views = 445, applications = 2,
            company = "Soweto Housing Initiative", contactEmail = "info@sowetohousing.org.za",
            contactPhone = "+27 11 567 8901", tags = listOf("housing", "ngo", "development")
        ),
        Lead(
            id = "6", title = "Carpenter Needed for Custom Kitchen Cabinets",
            description = "Skilled carpenter required to design and install custom kitchen cabinets in a new home in Soweto. Must provide portfolio of previous kitchen work. Solid wood preferred.",
            budget = 28000.0, location = "Soweto", province = "Gauteng",
            category = "CARPENTRY", type = "FIXED_PRICE", status = "OPEN", priority = "MEDIUM",
            isUrgent = false, createdAt = "2026-06-05T13:10:00Z", views = 98, applications = 6,
            company = "Mthembu Family", contactEmail = "smthembu@gmail.com",
            contactPhone = "+27 72 123 4567", tags = listOf("kitchen", "cabinets", "residential")
        ),
        Lead(
            id = "7", title = "Landscaping Design & Implementation for Estate",
            description = "Full landscaping project for a residential estate in Umhlanga. Includes garden design, irrigation system, paving, outdoor lighting, and indigenous plant selection.",
            budget = 65000.0, location = "Umhlanga", province = "KwaZulu-Natal",
            category = "LANDSCAPING", type = "PROJECT", status = "OPEN", priority = "LOW",
            isUrgent = false, createdAt = "2026-06-04T10:30:00Z", views = 167, applications = 9,
            company = "Umhlanga Ridge Estates", contactEmail = "gardens@umhlangaridge.co.za",
            contactPhone = "+27 31 234 5678", tags = listOf("landscaping", "garden", "premium")
        ),
        Lead(
            id = "8", title = "Security System Installation - Industrial Warehouse",
            description = "Need a security company to install comprehensive security system for a warehouse in Springs. CCTV cameras, motion sensors, alarm system, and access control required.",
            budget = 95000.0, location = "Springs", province = "Gauteng",
            category = "SECURITY", type = "TENDER", status = "OPEN", priority = "HIGH",
            isUrgent = true, createdAt = "2026-06-03T08:45:00Z", views = 278, applications = 4,
            company = "Springs Logistics Ltd", contactEmail = "ops@springslogistics.co.za",
            contactPhone = "+27 11 678 9012", tags = listOf("security", "cctv", "warehouse")
        ),
        Lead(
            id = "9", title = "IT Support & Maintenance Contract Needed",
            description = "Mid-sized law firm in Pretoria looking for an IT support company for ongoing maintenance and support. 50 workstations, server room, cloud migration project included.",
            budget = 15000.0, location = "Pretoria", province = "Gauteng",
            category = "IT_SERVICES", type = "MONTHLY", status = "OPEN", priority = "MEDIUM",
            isUrgent = false, createdAt = "2026-06-02T15:00:00Z", views = 134, applications = 7,
            company = "LegalWise Associates", contactEmail = "it@legalwise.co.za",
            contactPhone = "+27 12 345 6789", tags = listOf("it", "support", "maintenance")
        ),
        Lead(
            id = "10", title = "Transport Services for Mining Equipment",
            description = "Need a heavy haulage company to transport mining equipment from Johannesburg to Musina. Specialized low-bed trucks required. Load dimensions: 12m x 3.5m x 4m.",
            budget = 180000.0, location = " Musina", province = "Limpopo",
            category = "TRANSPORT", type = "QUOTE", status = "OPEN", priority = "HIGH",
            isUrgent = true, createdAt = "2026-06-01T07:30:00Z", views = 201, applications = 6,
            company = "Mining Logistics SA", contactEmail = "dispatch@mininglogistics.co.za",
            contactPhone = "+27 13 456 7890", tags = listOf("transport", "mining", "heavyhaulage")
        )
    )

    val USER = User(
        firstName = "Thabo",
        lastName = "Nkosi",
        email = "thabo.nkosi@example.com",
        company = "Nkosi Construction",
        type = "SERVICE_PROVIDER",
        stats = UserStats(newLeads = 12, completed = 48, inProgress = 6)
    )

    var savedLeadIds by mutableStateOf(listOf<String>())
    var applications by mutableStateOf(listOf<Application>())
    var currentUser: User? by mutableStateOf(null)
    var nextLeadId = 11
    var leadViewCount by mutableStateOf(0)

    private var lastAdIndex = -1

    private val adCreatives = listOf(
        AdCreative(
            advertiser = "BuildPro Tools",
            headline = "Build smarter, not harder",
            body = "Premium construction tools and equipment for professionals. Get 20% off your first order!",
            cta = "Shop Now",
            color = 0xFF7C3AED
        ),
        AdCreative(
            advertiser = "Swift Finance",
            headline = "Fast funding for your projects",
            body = "Get approved in 24 hours with competitive rates for service providers.",
            cta = "Apply Now",
            color = 0xFF06B6D4
        ),
        AdCreative(
            advertiser = "LeadGenius CRM",
            headline = "Never miss a lead again",
            body = "The #1 CRM for service professionals. Start your free trial today.",
            cta = "Try Free",
            color = 0xFFF59E0B
        ),
        AdCreative(
            advertiser = "SafeSite Insurance",
            headline = "Protect your business",
            body = "Comprehensive liability insurance tailored for contractors and builders.",
            cta = "Get Quote",
            color = 0xFF10B981
        ),
        AdCreative(
            advertiser = "TruckIt Logistics",
            headline = "Delivering your success",
            body = "Reliable nationwide delivery for construction materials and equipment.",
            cta = "Get a Quote",
            color = 0xFF3B82F6
        )
    )

    fun getLeads(): List<Lead> = _mockLeads

    fun getLead(id: String): Lead? = _mockLeads.find { it.id == id }

    fun createLead(data: Map<String, Any>): Lead {
        val id = nextLeadId.toString()
        nextLeadId++
        val lead = Lead(
            id = id,
            title = data["title"] as? String ?: "",
            description = data["description"] as? String ?: "",
            budget = data["budget"] as? Double ?: 0.0,
            location = data["location"] as? String ?: "",
            province = data["province"] as? String ?: "",
            category = data["category"] as? String ?: "",
            type = data["type"] as? String ?: "",
            status = "OPEN",
            priority = data["priority"] as? String ?: "MEDIUM",
            isUrgent = data["priority"] == "URGENT" || data["priority"] == "HIGH",
            createdAt = "2026-06-17T12:00:00Z",
            views = 0,
            applications = 0,
            company = data["company"] as? String ?: "",
            contactEmail = data["contactEmail"] as? String ?: "",
            contactPhone = data["contactPhone"] as? String ?: "",
            tags = (data["tags"] as? String)?.split(",")?.map { it.trim() }?.filter { it.isNotEmpty() } ?: emptyList()
        )
        _mockLeads.toMutableList().also { it.add(lead); _mockLeads = it }
        return lead
    }

    fun updateLead(id: String, data: Map<String, Any>) {
        val index = _mockLeads.indexOfFirst { it.id == id }
        if (index == -1) return
        val current = _mockLeads[index]
        val updated = current.copy(
            title = data["title"] as? String ?: current.title,
            description = data["description"] as? String ?: current.description,
            budget = data["budget"] as? Double ?: current.budget,
            location = data["location"] as? String ?: current.location,
            province = data["province"] as? String ?: current.province,
            category = data["category"] as? String ?: current.category,
            type = data["type"] as? String ?: current.type,
            status = data["status"] as? String ?: current.status,
            priority = data["priority"] as? String ?: current.priority,
            isUrgent = data["priority"] == "URGENT" || data["priority"] == "HIGH",
            company = data["company"] as? String ?: current.company,
            contactEmail = data["contactEmail"] as? String ?: current.contactEmail,
            contactPhone = data["contactPhone"] as? String ?: current.contactPhone,
            tags = (data["tags"] as? String)?.split(",")?.map { it.trim() }?.filter { it.isNotEmpty() } ?: current.tags
        )
        _mockLeads.toMutableList().also { it[index] = updated; _mockLeads = it }
    }

    fun deleteLead(id: String) {
        _mockLeads = _mockLeads.filter { it.id != id }
    }

    fun saveLead(id: String) {
        if (!savedLeadIds.contains(id)) {
            savedLeadIds = savedLeadIds + id
        }
    }

    fun unsaveLead(id: String) {
        savedLeadIds = savedLeadIds.filter { it != id }
    }

    fun isLeadSaved(id: String): Boolean = savedLeadIds.contains(id)

    fun applyToLead(id: String) {
        applications = applications + Application(id, "PENDING", "2026-06-17T12:00:00Z")
    }

    fun hasApplied(id: String): Boolean = applications.any { it.leadId == id }

    fun getSavedLeads(): List<Lead> = _mockLeads.filter { savedLeadIds.contains(it.id) }

    fun getMyApplications(): List<Pair<Lead, Application>> {
        return applications.mapNotNull { app ->
            _mockLeads.find { it.id == app.leadId }?.let { it to app }
        }
    }

    fun updateProfile(data: Map<String, Any>) {
        val user = currentUser ?: return
        currentUser = user.copy(
            firstName = data["firstName"] as? String ?: user.firstName,
            lastName = data["lastName"] as? String ?: user.lastName,
            email = data["email"] as? String ?: user.email,
            company = data["company"] as? String ?: user.company,
            type = data["type"] as? String ?: user.type
        )
    }

    fun shouldShowAd(): Boolean = leadViewCount > 0 && leadViewCount % 3 == 0

    fun recordLeadView(): Boolean {
        leadViewCount++
        return shouldShowAd()
    }

    fun getAdCreative(): AdCreative {
        var index: Int
        do {
            index = (0 until adCreatives.size).random()
        } while (index == lastAdIndex && adCreatives.size > 1)
        lastAdIndex = index
        return adCreatives[index]
    }

    private var _mockLeads: List<Lead> = initialLeads
}
