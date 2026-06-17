package com.leadsconnection.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.leadsconnection.data.LeadsRepository
import com.leadsconnection.ui.components.TopBar
import com.leadsconnection.ui.theme.BackgroundDark
import com.leadsconnection.ui.theme.BackgroundMid
import com.leadsconnection.ui.theme.CardBackground
import com.leadsconnection.ui.theme.GlassBorder
import com.leadsconnection.ui.theme.Primary
import com.leadsconnection.ui.theme.TextMuted
import com.leadsconnection.ui.theme.TextPrimary
import com.leadsconnection.ui.theme.TextSecondary

private val leadCategories = listOf(
    "PLUMBING", "IT_SERVICES", "ELECTRICAL", "BUSINESS",
    "CARPENTRY", "LANDSCAPING", "SECURITY", "TRANSPORT"
)

private val leadTypes = listOf("FIXED_PRICE", "PROJECT", "TENDER", "CONTRACT", "MONTHLY", "QUOTE", "INVESTMENT")

private val leadPriorities = listOf("LOW", "MEDIUM", "HIGH", "URGENT")

private val leadProvinces = listOf(
    "Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal",
    "Limpopo", "Mpumalanga", "Northern Cape", "North West", "Western Cape"
)

private val leadStatuses = listOf("OPEN", "IN_PROGRESS", "CLOSED")

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EditLeadScreen(
    leadId: String,
    onBackClick: () -> Unit,
    onSuccess: () -> Unit
) {
    val existingLead = LeadsRepository.getLead(leadId)
    if (existingLead == null) {
        Box(
            modifier = Modifier.fillMaxSize().background(BackgroundDark),
            contentAlignment = Alignment.Center
        ) {
            Text("Lead not found", color = TextSecondary)
        }
        return
    }

    var title by remember { mutableStateOf(existingLead.title) }
    var description by remember { mutableStateOf(existingLead.description) }
    var budgetText by remember { mutableStateOf(existingLead.budget.toLong().toString()) }
    var priority by remember { mutableStateOf(existingLead.priority) }
    var location by remember { mutableStateOf(existingLead.location) }
    var province by remember { mutableStateOf(existingLead.province) }
    var category by remember { mutableStateOf(existingLead.category) }
    var type by remember { mutableStateOf(existingLead.type) }
    var status by remember { mutableStateOf(existingLead.status) }
    var contactEmail by remember { mutableStateOf(existingLead.contactEmail) }
    var contactPhone by remember { mutableStateOf(existingLead.contactPhone) }
    var company by remember { mutableStateOf(existingLead.company) }
    var tags by remember { mutableStateOf(existingLead.tags.joinToString(", ")) }
    var error by remember { mutableStateOf<String?>(null) }

    var priorityExpanded by remember { mutableStateOf(false) }
    var provinceExpanded by remember { mutableStateOf(false) }
    var categoryExpanded by remember { mutableStateOf(false) }
    var typeExpanded by remember { mutableStateOf(false) }
    var statusExpanded by remember { mutableStateOf(false) }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(
                Brush.verticalGradient(
                    colors = listOf(BackgroundDark, BackgroundMid, CardBackground)
                )
            )
    ) {
        Column(modifier = Modifier.fillMaxSize()) {
            TopBar(
                title = "Edit Lead",
                onBackClick = onBackClick
            )

            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .verticalScroll(rememberScrollState())
                    .padding(16.dp),
                verticalArrangement = Arrangement.spacedBy(14.dp)
            ) {
                Text(
                    text = "Edit Lead",
                    style = MaterialTheme.typography.headlineMedium,
                    fontWeight = FontWeight.Bold,
                    color = TextPrimary
                )

                OutlinedTextField(
                    value = title,
                    onValueChange = { title = it; error = null },
                    label = { Text("Title *") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(12.dp),
                    colors = editFieldColors()
                )

                OutlinedTextField(
                    value = description,
                    onValueChange = { description = it; error = null },
                    label = { Text("Description *") },
                    minLines = 3,
                    maxLines = 5,
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(12.dp),
                    colors = editFieldColors()
                )

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    OutlinedTextField(
                        value = budgetText,
                        onValueChange = { budgetText = it },
                        label = { Text("Budget (R) *") },
                        singleLine = true,
                        modifier = Modifier.weight(1f),
                        shape = RoundedCornerShape(12.dp),
                        colors = editFieldColors()
                    )

                    ExposedDropdownMenuBox(
                        expanded = priorityExpanded,
                        onExpandedChange = { priorityExpanded = it },
                        modifier = Modifier.weight(1f)
                    ) {
                        OutlinedTextField(
                            value = priority,
                            onValueChange = {},
                            readOnly = true,
                            label = { Text("Priority") },
                            trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = priorityExpanded) },
                            modifier = Modifier.fillMaxWidth(),
                            shape = RoundedCornerShape(12.dp),
                            colors = editFieldColors()
                        )
                        ExposedDropdownMenu(
                            expanded = priorityExpanded,
                            onDismissRequest = { priorityExpanded = false }
                        ) {
                            leadPriorities.forEach { p ->
                                DropdownMenuItem(
                                    text = { Text(p) },
                                    onClick = { priority = p; priorityExpanded = false }
                                )
                            }
                        }
                    }
                }

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    OutlinedTextField(
                        value = location,
                        onValueChange = { location = it },
                        label = { Text("Location *") },
                        singleLine = true,
                        modifier = Modifier.weight(1f),
                        shape = RoundedCornerShape(12.dp),
                        colors = editFieldColors()
                    )

                    ExposedDropdownMenuBox(
                        expanded = provinceExpanded,
                        onExpandedChange = { provinceExpanded = it },
                        modifier = Modifier.weight(1f)
                    ) {
                        OutlinedTextField(
                            value = province,
                            onValueChange = {},
                            readOnly = true,
                            label = { Text("Province") },
                            trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = provinceExpanded) },
                            modifier = Modifier.fillMaxWidth(),
                            shape = RoundedCornerShape(12.dp),
                            colors = editFieldColors()
                        )
                        ExposedDropdownMenu(
                            expanded = provinceExpanded,
                            onDismissRequest = { provinceExpanded = false }
                        ) {
                            leadProvinces.forEach { p ->
                                DropdownMenuItem(
                                    text = { Text(p) },
                                    onClick = { province = p; provinceExpanded = false }
                                )
                            }
                        }
                    }
                }

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    ExposedDropdownMenuBox(
                        expanded = categoryExpanded,
                        onExpandedChange = { categoryExpanded = it },
                        modifier = Modifier.weight(1f)
                    ) {
                        OutlinedTextField(
                            value = category,
                            onValueChange = {},
                            readOnly = true,
                            label = { Text("Category") },
                            trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = categoryExpanded) },
                            modifier = Modifier.fillMaxWidth(),
                            shape = RoundedCornerShape(12.dp),
                            colors = editFieldColors()
                        )
                        ExposedDropdownMenu(
                            expanded = categoryExpanded,
                            onDismissRequest = { categoryExpanded = false }
                        ) {
                            leadCategories.forEach { c ->
                                DropdownMenuItem(
                                    text = { Text(c.replace("_", " ")) },
                                    onClick = { category = c; categoryExpanded = false }
                                )
                            }
                        }
                    }

                    ExposedDropdownMenuBox(
                        expanded = typeExpanded,
                        onExpandedChange = { typeExpanded = it },
                        modifier = Modifier.weight(1f)
                    ) {
                        OutlinedTextField(
                            value = type,
                            onValueChange = {},
                            readOnly = true,
                            label = { Text("Type") },
                            trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = typeExpanded) },
                            modifier = Modifier.fillMaxWidth(),
                            shape = RoundedCornerShape(12.dp),
                            colors = editFieldColors()
                        )
                        ExposedDropdownMenu(
                            expanded = typeExpanded,
                            onDismissRequest = { typeExpanded = false }
                        ) {
                            leadTypes.forEach { t ->
                                DropdownMenuItem(
                                    text = { Text(t.replace("_", " ")) },
                                    onClick = { type = t; typeExpanded = false }
                                )
                            }
                        }
                    }
                }

                ExposedDropdownMenuBox(
                    expanded = statusExpanded,
                    onExpandedChange = { statusExpanded = it }
                ) {
                    OutlinedTextField(
                        value = status,
                        onValueChange = {},
                        readOnly = true,
                        label = { Text("Status") },
                        trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = statusExpanded) },
                        modifier = Modifier.fillMaxWidth(),
                        shape = RoundedCornerShape(12.dp),
                        colors = editFieldColors()
                    )
                    ExposedDropdownMenu(
                        expanded = statusExpanded,
                        onDismissRequest = { statusExpanded = false }
                    ) {
                        leadStatuses.forEach { s ->
                            DropdownMenuItem(
                                text = { Text(s.replace("_", " ")) },
                                onClick = { status = s; statusExpanded = false }
                            )
                        }
                    }
                }

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    OutlinedTextField(
                        value = contactEmail,
                        onValueChange = { contactEmail = it },
                        label = { Text("Contact Email") },
                        singleLine = true,
                        modifier = Modifier.weight(1f),
                        shape = RoundedCornerShape(12.dp),
                        colors = editFieldColors()
                    )
                    OutlinedTextField(
                        value = contactPhone,
                        onValueChange = { contactPhone = it },
                        label = { Text("Contact Phone") },
                        singleLine = true,
                        modifier = Modifier.weight(1f),
                        shape = RoundedCornerShape(12.dp),
                        colors = editFieldColors()
                    )
                }

                OutlinedTextField(
                    value = company,
                    onValueChange = { company = it },
                    label = { Text("Company") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(12.dp),
                    colors = editFieldColors()
                )

                OutlinedTextField(
                    value = tags,
                    onValueChange = { tags = it },
                    label = { Text("Tags (comma separated)") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(12.dp),
                    colors = editFieldColors()
                )

                if (error != null) {
                    Text(
                        text = error!!,
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.error
                    )
                }

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    OutlinedButton(
                        onClick = onBackClick,
                        modifier = Modifier
                            .weight(1f)
                            .height(48.dp),
                        shape = RoundedCornerShape(12.dp),
                        colors = ButtonDefaults.outlinedButtonColors(
                            contentColor = TextSecondary
                        ),
                        border = GlassBorder
                    ) {
                        Text("Cancel", fontWeight = FontWeight.SemiBold)
                    }

                    Button(
                        onClick = {
                            when {
                                title.isBlank() -> error = "Title is required"
                                description.isBlank() -> error = "Description is required"
                                budgetText.isBlank() -> error = "Budget is required"
                                location.isBlank() -> error = "Location is required"
                                else -> {
                                    val budget = budgetText.replace(",", "").toDoubleOrNull() ?: 0.0
                                    val data = mutableMapOf(
                                        "title" to title,
                                        "description" to description,
                                        "budget" to budget,
                                        "priority" to priority,
                                        "status" to status,
                                        "location" to location,
                                        "province" to province,
                                        "category" to category,
                                        "type" to type,
                                        "contactEmail" to contactEmail,
                                        "contactPhone" to contactPhone,
                                        "company" to company,
                                        "tags" to tags
                                    )
                                    LeadsRepository.updateLead(leadId, data)
                                    onSuccess()
                                }
                            }
                        },
                        modifier = Modifier
                            .weight(1f)
                            .height(48.dp),
                        shape = RoundedCornerShape(12.dp),
                        colors = ButtonDefaults.buttonColors(
                            containerColor = Primary
                        )
                    ) {
                        Text(
                            text = "Save Changes",
                            style = MaterialTheme.typography.labelLarge,
                            fontWeight = FontWeight.SemiBold
                        )
                    }
                }

                Spacer(modifier = Modifier.height(16.dp))
            }
        }
    }
}

@Composable
private fun editFieldColors() = OutlinedTextFieldDefaults.colors(
    focusedBorderColor = Primary,
    unfocusedBorderColor = GlassBorder,
    cursorColor = Primary,
    focusedLabelColor = Primary,
    unfocusedLabelColor = TextMuted,
    focusedTextColor = TextPrimary,
    unfocusedTextColor = TextPrimary
)
