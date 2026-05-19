import 'package:flutter/material.dart';

class AppTheme {
  static const _bg = Color(0xFF0D1017);
  static const _panel = Color(0xFF171C27);
  static const _panelAlt = Color(0xFF1E2433);
  static const _accent = Color(0xFF61D4A0);
  static const _textPrimary = Color(0xFFE7ECF4);
  static const _textSecondary = Color(0xFF9CA8BC);

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark(
        primary: _accent,
        secondary: _accent,
        surface: _panel,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: _textPrimary,
        displayColor: _textPrimary,
      ),
      cardTheme: const CardThemeData(
        color: _panel,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: _textPrimary),
      dividerColor: _panelAlt,
      extensions: const <ThemeExtension<dynamic>>[
        AppPalette(
          panel: _panel,
          panelAlt: _panelAlt,
          accent: _accent,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        ),
      ],
    );
  }
}

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.panel,
    required this.panelAlt,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
  });

  final Color panel;
  final Color panelAlt;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;

  @override
  ThemeExtension<AppPalette> copyWith({
    Color? panel,
    Color? panelAlt,
    Color? accent,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return AppPalette(
      panel: panel ?? this.panel,
      panelAlt: panelAlt ?? this.panelAlt,
      accent: accent ?? this.accent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<AppPalette> lerp(covariant ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;

    return AppPalette(
      panel: Color.lerp(panel, other.panel, t) ?? panel,
      panelAlt: Color.lerp(panelAlt, other.panelAlt, t) ?? panelAlt,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
    );
  }
}

extension ThemePaletteX on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
