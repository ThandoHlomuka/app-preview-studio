package com.leadsconnection.navigation

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.leadsconnection.data.LeadsRepository
import com.leadsconnection.ui.screens.EditLeadScreen
import com.leadsconnection.ui.screens.EditProfileScreen
import com.leadsconnection.ui.screens.HomeScreen
import com.leadsconnection.ui.screens.LeadDetailScreen
import com.leadsconnection.ui.screens.LeadsListScreen
import com.leadsconnection.ui.screens.LoginScreen
import com.leadsconnection.ui.screens.MyApplicationsScreen
import com.leadsconnection.ui.screens.PostLeadScreen
import com.leadsconnection.ui.screens.ProfileScreen
import com.leadsconnection.ui.screens.SavedLeadsScreen
import com.leadsconnection.ui.screens.SignupScreen

@Composable
fun NavGraph(
    navController: NavHostController,
    modifier: Modifier = Modifier
) {
    val startDestination = if (LeadsRepository.currentUser != null) "home" else "login"

    NavHost(
        navController = navController,
        startDestination = startDestination,
        modifier = modifier
    ) {
        composable("login") {
            LoginScreen(
                onLoginSuccess = {
                    navController.navigate("home") {
                        popUpTo("login") { inclusive = true }
                    }
                },
                onSignUpClick = {
                    navController.navigate("signup")
                }
            )
        }

        composable("signup") {
            SignupScreen(
                onSignUpSuccess = {
                    navController.navigate("home") {
                        popUpTo("login") { inclusive = true }
                    }
                },
                onLoginClick = {
                    navController.popBackStack()
                }
            )
        }

        composable("home") {
            val currentUser = LeadsRepository.currentUser
            if (currentUser == null) {
                navController.navigate("login") {
                    popUpTo("home") { inclusive = true }
                }
                return@composable
            }
            HomeScreen(
                onNavigateToLeads = { navController.navigate("leads") },
                onNavigateToProfile = { navController.navigate("profile") },
                onNavigateToLeadDetail = { id -> navController.navigate("lead/$id") },
                onNavigateToPostLead = { navController.navigate("post_lead") },
                onNavigateToSavedLeads = { navController.navigate("saved_leads") },
                onNavigateToMyApps = { navController.navigate("my_apps") }
            )
        }

        composable("leads") {
            val currentUser = LeadsRepository.currentUser
            if (currentUser == null) {
                navController.navigate("login") {
                    popUpTo("leads") { inclusive = true }
                }
                return@composable
            }
            LeadsListScreen(
                onNavigateToLeadDetail = { id -> navController.navigate("lead/$id") },
                onBackClick = { navController.popBackStack() }
            )
        }

        composable(
            route = "lead/{id}",
            arguments = listOf(navArgument("id") { type = NavType.StringType })
        ) { backStackEntry ->
            val leadId = backStackEntry.arguments?.getString("id") ?: return@composable
            val currentUser = LeadsRepository.currentUser
            if (currentUser == null) {
                navController.navigate("login") {
                    popUpTo("lead/{id}") { inclusive = true }
                }
                return@composable
            }
            LeadDetailScreen(
                leadId = leadId,
                onBackClick = { navController.popBackStack() },
                onEditClick = { navController.navigate("edit_lead/$leadId") },
                onDeleteSuccess = {
                    navController.popBackStack()
                }
            )
        }

        composable("post_lead") {
            val currentUser = LeadsRepository.currentUser
            if (currentUser == null) {
                navController.navigate("login") {
                    popUpTo("post_lead") { inclusive = true }
                }
                return@composable
            }
            PostLeadScreen(
                onBackClick = { navController.popBackStack() },
                onSuccess = { id ->
                    navController.navigate("lead/$id") {
                        popUpTo("post_lead") { inclusive = true }
                    }
                }
            )
        }

        composable(
            route = "edit_lead/{id}",
            arguments = listOf(navArgument("id") { type = NavType.StringType })
        ) { backStackEntry ->
            val leadId = backStackEntry.arguments?.getString("id") ?: return@composable
            val currentUser = LeadsRepository.currentUser
            if (currentUser == null) {
                navController.navigate("login") {
                    popUpTo("edit_lead/{id}") { inclusive = true }
                }
                return@composable
            }
            EditLeadScreen(
                leadId = leadId,
                onBackClick = { navController.popBackStack() },
                onSuccess = {
                    navController.popBackStack()
                }
            )
        }

        composable("profile") {
            val currentUser = LeadsRepository.currentUser
            if (currentUser == null) {
                navController.navigate("login") {
                    popUpTo("profile") { inclusive = true }
                }
                return@composable
            }
            ProfileScreen(
                onBackClick = { navController.popBackStack() },
                onNavigateToEditProfile = { navController.navigate("edit_profile") },
                onNavigateToSavedLeads = { navController.navigate("saved_leads") },
                onNavigateToMyApps = { navController.navigate("my_apps") },
                onLogout = {
                    LeadsRepository.currentUser = null
                    navController.navigate("login") {
                        popUpTo("home") { inclusive = true }
                        popUpTo("profile") { inclusive = true }
                    }
                }
            )
        }

        composable("edit_profile") {
            EditProfileScreen(
                onBackClick = { navController.popBackStack() },
                onSuccess = { navController.popBackStack() }
            )
        }

        composable("saved_leads") {
            SavedLeadsScreen(
                onBackClick = { navController.popBackStack() },
                onNavigateToLeadDetail = { id -> navController.navigate("lead/$id") }
            )
        }

        composable("my_apps") {
            MyApplicationsScreen(
                onBackClick = { navController.popBackStack() },
                onNavigateToLeadDetail = { id -> navController.navigate("lead/$id") }
            )
        }
    }
}
