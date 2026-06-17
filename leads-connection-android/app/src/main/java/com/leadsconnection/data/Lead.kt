package com.leadsconnection.data

data class Lead(
    val id: String,
    val title: String,
    val description: String,
    val budget: Double,
    val location: String,
    val province: String,
    val category: String,
    val type: String,
    val status: String,
    val priority: String,
    val isUrgent: Boolean,
    val createdAt: String,
    val views: Int,
    val applications: Int,
    val company: String,
    val contactEmail: String,
    val contactPhone: String,
    val tags: List<String>
)

data class User(
    val firstName: String,
    val lastName: String,
    val email: String,
    val company: String,
    val type: String,
    val stats: UserStats
)

data class UserStats(
    val newLeads: Int,
    val completed: Int,
    val inProgress: Int
)

data class Application(
    val leadId: String,
    val status: String,
    val appliedAt: String
)

data class AdCreative(
    val advertiser: String,
    val headline: String,
    val body: String,
    val cta: String,
    val color: Long
)
