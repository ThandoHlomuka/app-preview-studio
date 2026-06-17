package com.leadsconnection.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.Composable

private val LeadsDarkColorScheme = darkColorScheme(
    primary = Primary,
    onPrimary = TextPrimary,
    primaryContainer = PrimaryStart,
    onPrimaryContainer = TextPrimary,
    secondary = Secondary,
    onSecondary = TextPrimary,
    secondaryContainer = Secondary,
    onSecondaryContainer = TextPrimary,
    tertiary = AccentStart,
    onTertiary = TextPrimary,
    background = BackgroundDark,
    onBackground = TextPrimary,
    surface = BackgroundMid,
    onSurface = TextPrimary,
    surfaceVariant = CardBackground,
    onSurfaceVariant = TextSecondary,
    error = Error,
    onError = TextPrimary,
    outline = CardBorder,
    outlineVariant = GlassBorder
)

@Composable
fun LeadsConnectionTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = LeadsDarkColorScheme,
        typography = LeadsTypography,
        content = content
    )
}
