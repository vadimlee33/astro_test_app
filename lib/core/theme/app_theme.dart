import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'text_styles.dart';
import 'app_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.lightColorScheme,
      textTheme: _buildTextTheme(AppColorSchemes.lightColorScheme),
      appBarTheme: _buildAppBarTheme(AppColorSchemes.lightColorScheme),
      elevatedButtonTheme: _buildElevatedButtonTheme(AppColorSchemes.lightColorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(AppColorSchemes.lightColorScheme),
      inputDecorationTheme: _buildInputDecorationTheme(AppColorSchemes.lightColorScheme),
      cardTheme: _buildCardTheme(AppColorSchemes.lightColorScheme),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(AppColorSchemes.lightColorScheme),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.darkColorScheme,
      textTheme: _buildTextTheme(AppColorSchemes.darkColorScheme),
      appBarTheme: _buildAppBarTheme(AppColorSchemes.darkColorScheme),
      elevatedButtonTheme: _buildElevatedButtonTheme(AppColorSchemes.darkColorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(AppColorSchemes.darkColorScheme),
      inputDecorationTheme: _buildInputDecorationTheme(AppColorSchemes.darkColorScheme),
      cardTheme: _buildCardTheme(AppColorSchemes.darkColorScheme),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(AppColorSchemes.darkColorScheme),
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: colorScheme.onSurface),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: colorScheme.onSurface),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: colorScheme.onSurface),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: colorScheme.onSurface),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: colorScheme.onSurface),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: colorScheme.onSurface),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: colorScheme.onSurface),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: colorScheme.onSurface),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: colorScheme.onSurface),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: colorScheme.onSurface),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: colorScheme.onSurface),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: colorScheme.onSurface),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: colorScheme.onSurface),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: colorScheme.onSurface),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: colorScheme.onSurface),
    );
  }

  static AppBarTheme _buildAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: AppStyles.elevationSmall,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(color: colorScheme.onSurface),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: AppStyles.elevatedButtonStyle(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: AppStyles.outlinedButtonStyle(
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: AppStyles.roundedMedium,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppStyles.roundedMedium,
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppStyles.roundedMedium,
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppStyles.roundedMedium,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: colorScheme.onSurfaceVariant),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: colorScheme.onSurfaceVariant),
    );
  }

  static CardTheme _buildCardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
      elevation: AppStyles.elevationSmall,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.roundedMedium,
      ),
    );
  }

  static FloatingActionButtonThemeData _buildFloatingActionButtonTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: AppStyles.elevationMedium,
    );
  }
} 