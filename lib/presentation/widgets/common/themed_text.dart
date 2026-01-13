import 'package:flutter/material.dart';
import 'package:quote_vault/core/theme/text_theme_extension.dart';

/// Widget that provides easy access to themed text styles
class ThemedText extends StatelessWidget {
  final String text;
  final ThemedTextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height; // Line height
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<Shadow>? shadows;
  final String? fontFamily;
  final Color? customColor; // Override theme color
  final EdgeInsetsGeometry? padding;
  final bool softWrap;
  final TextDirection? textDirection;
  final Locale? locale;
  final TextScaler? textScaler;
  final String? semanticsLabel;

  const ThemedText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.customColor,
    this.padding,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.semanticsLabel,
  });

  // Convenience constructors
  const ThemedText.heading(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.customColor,
    this.padding,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.semanticsLabel,
  }) : style = ThemedTextStyle.heading;

  const ThemedText.subText(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.customColor,
    this.padding,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.semanticsLabel,
  }) : style = ThemedTextStyle.subText;

  const ThemedText.accent(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.customColor,
    this.padding,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.semanticsLabel,
  }) : style = ThemedTextStyle.accent;

  const ThemedText.body(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.customColor,
    this.padding,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.semanticsLabel,
  }) : style = ThemedTextStyle.body;

  const ThemedText.caption(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.customColor,
    this.padding,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.semanticsLabel,
  }) : style = ThemedTextStyle.caption;

  @override
  Widget build(BuildContext context) {
    final textColors = context.textColors;
    
    Color color;
    TextStyle baseStyle;
    
    switch (style) {
      case ThemedTextStyle.heading:
        color = customColor ?? textColors.headingColor;
        baseStyle = Theme.of(context).textTheme.headlineMedium ?? const TextStyle();
        break;
      case ThemedTextStyle.subText:
        color = customColor ?? textColors.subTextColor;
        baseStyle = Theme.of(context).textTheme.titleMedium ?? const TextStyle();
        break;
      case ThemedTextStyle.accent:
        color = customColor ?? textColors.accentColor;
        baseStyle = Theme.of(context).textTheme.labelLarge ?? const TextStyle();
        break;
      case ThemedTextStyle.body:
        color = customColor ?? textColors.bodyTextColor;
        baseStyle = Theme.of(context).textTheme.bodyLarge ?? const TextStyle();
        break;
      case ThemedTextStyle.caption:
        color = customColor ?? textColors.captionColor;
        baseStyle = Theme.of(context).textTheme.bodySmall ?? const TextStyle();
        break;
    }

    final textWidget = Text(
      text,
      style: baseStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        shadows: shadows,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      locale: locale,
      textScaler: textScaler,
      semanticsLabel: semanticsLabel,
    );

    // Wrap with padding if provided
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: textWidget,
      );
    }

    return textWidget;
  }
}

enum ThemedTextStyle {
  heading,
  subText,
  accent,
  body,
  caption,
}