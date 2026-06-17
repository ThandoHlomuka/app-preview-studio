package com.leadsconnection.ui.screens

import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowForwardIos
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.leadsconnection.data.LeadsRepository
import com.leadsconnection.ui.components.StatCard
import com.leadsconnection.ui.components.TopBar
import com.leadsconnection.ui.theme.BackgroundDark
import com.leadsconnection.ui.theme.BackgroundMid
import com.leadsconnection.ui.theme.CardBackground
import com.leadsconnection.ui.theme.Error
import com.leadsconnection.ui.theme.GlassBorder
import com.leadsconnection.ui.theme.Primary
import com.leadsconnection.ui.theme.PrimaryEnd
import com.leadsconnection.ui.theme.PrimaryStart
import com.leadsconnection.ui.theme.Success
import com.leadsconnection.ui.theme.TextMuted
import com.leadsconnection.ui.theme.TextPrimary
import com.leadsconnection.ui.theme.TextSecondary
import com.leadsconnection.ui.theme.Warning

data class SettingsItem(
    val label: String,
    val route: String?,
    val showToast: String? = null
)

private val settingsItems = listOf(
    SettingsItem("Edit Profile", "edit_profile"),
    SettingsItem("Saved Leads", "saved_leads"),
    SettingsItem("My Applications", "my_apps"),
    SettingsItem("Notification Preferences", null, "Notification preferences coming soon"),
    SettingsItem("Service Categories", null, "Service categories coming soon"),
    SettingsItem("Service Areas", null, "Service areas coming soon"),
    SettingsItem("Privacy & Security", null, "Privacy & security coming soon"),
    SettingsItem("Help & Support", null, "Help & support coming soon")
)

@Composable
fun ProfileScreen(
    onBackClick: () -> Unit,
    onNavigateToEditProfile: () -> Unit,
    onNavigateToSavedLeads: () -> Unit,
    onNavigateToMyApps: () -> Unit,
    onLogout: () -> Unit
) {
    val currentUser = LeadsRepository.currentUser ?: return
    val context = LocalContext.current
    val savedLeadsCount = LeadsRepository.savedLeadIds.size
    val applicationsCount = LeadsRepository.applications.size

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(
                Brush.verticalGradient(
                    colors = listOf(BackgroundDark, BackgroundMid, CardBackground)
                )
            )
    ) {
        TopBar(
            title = "Profile",
            onBackClick = onBackClick
        )

        Column(
            modifier = Modifier
                .fillMaxSize()
                .verticalScroll(rememberScrollState())
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            Column(
                modifier = Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Box(
                    modifier = Modifier
                        .size(80.dp)
                        .clip(CircleShape)
                        .background(
                            Brush.linearGradient(
                                colors = listOf(PrimaryStart, PrimaryEnd)
                            )
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = "${currentUser.firstName.take(1)}${currentUser.lastName.take(1)}",
                        style = MaterialTheme.typography.headlineLarge,
                        fontWeight = FontWeight.Bold,
                        color = Color.White
                    )
                }

                Text(
                    text = "${currentUser.firstName} ${currentUser.lastName}",
                    style = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold,
                    color = TextPrimary
                )

                Text(
                    text = currentUser.email,
                    style = MaterialTheme.typography.bodyMedium,
                    color = TextSecondary
                )

                Box(
                    modifier = Modifier
                        .clip(RoundedCornerShape(20.dp))
                        .background(Primary.copy(alpha = 0.15f))
                        .padding(horizontal = 16.dp, vertical = 4.dp)
                ) {
                    Text(
                        text = "Service Provider",
                        style = MaterialTheme.typography.labelSmall,
                        color = Primary,
                        fontWeight = FontWeight.Medium
                    )
                }
            }

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                StatCard(
                    value = "${currentUser.stats.inProgress}",
                    label = "Active",
                    valueColor = Primary,
                    modifier = Modifier.weight(1f)
                )
                StatCard(
                    value = "${currentUser.stats.completed}",
                    label = "Completed",
                    valueColor = Success,
                    modifier = Modifier.weight(1f)
                )
                StatCard(
                    value = "4.8",
                    label = "Rating",
                    valueColor = Warning,
                    modifier = Modifier.weight(1f)
                )
            }

            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .clip(RoundedCornerShape(12.dp))
                    .background(CardBackground)
                    .padding(8.dp)
            ) {
                settingsItems.forEach { item ->
                    val onClick = when (item.route) {
                        "edit_profile" -> onNavigateToEditProfile
                        "saved_leads" -> onNavigateToSavedLeads
                        "my_apps" -> onNavigateToMyApps
                        else -> null
                    }
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable {
                                if (onClick != null) onClick()
                                else if (item.showToast != null) {
                                    Toast.makeText(context, item.showToast, Toast.LENGTH_SHORT).show()
                                }
                            }
                            .padding(horizontal = 12.dp, vertical = 14.dp),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        val trailingText = when (item.label) {
                            "Saved Leads" -> if (savedLeadsCount > 0) "$savedLeadsCount" else null
                            "My Applications" -> if (applicationsCount > 0) "$applicationsCount" else null
                            else -> null
                        }
                        Text(
                            text = item.label,
                            style = MaterialTheme.typography.bodyLarge,
                            color = TextPrimary
                        )
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            if (trailingText != null) {
                                Text(
                                    text = trailingText,
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = TextSecondary
                                )
                            }
                            Icon(
                                imageVector = Icons.Default.ArrowForwardIos,
                                contentDescription = null,
                                tint = TextMuted,
                                modifier = Modifier.size(16.dp)
                            )
                        }
                    }
                    if (item != settingsItems.last()) {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(0.5.dp)
                                .background(GlassBorder)
                        )
                    }
                }
            }

            OutlinedButton(
                onClick = onLogout,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(48.dp),
                shape = RoundedCornerShape(12.dp),
                colors = ButtonDefaults.outlinedButtonColors(
                    contentColor = Error
                ),
                border = Error.copy(alpha = 0.4f)
            ) {
                Text(
                    text = "Logout",
                    style = MaterialTheme.typography.labelLarge,
                    fontWeight = FontWeight.SemiBold
                )
            }

            Spacer(modifier = Modifier.height(16.dp))
        }
    }
}
