library phosphor_flutter;

import 'package:flutter/material.dart';

class PhosphorIcon extends Icon {
  const PhosphorIcon(
    IconData icon, {
    Key? key,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
    this.duotoneSecondaryOpacity = 0.20,
    this.duotoneSecondaryColor,
    this.duotone = false,
  }) : super(
          icon,
          color: color,
          fill: fill,
          grade: grade,
          key: key,
          opticalSize: opticalSize,
          semanticLabel: semanticLabel,
          shadows: shadows,
          size: size,
          textDirection: textDirection,
          weight: weight,
        );

  final double duotoneSecondaryOpacity;
  final Color? duotoneSecondaryColor;
  final bool duotone;

  @override
  Widget build(BuildContext context) {
    final iconData = icon;
    if (duotone && iconData?.fontFamily == 'PhosphorDuotone') {
      final iconTheme = IconTheme.of(context);
      final iconSize = size ?? iconTheme.size;
      final iconColor = duotoneSecondaryColor ?? color ?? iconTheme.color;
      final iconOpacity = iconTheme.opacity ?? 1.0;
      Widget secondaryIcon = Text(
        String.fromCharCode(iconData!.codePoint - 1),
        overflow: TextOverflow.visible,
        textDirection: textDirection,
        style: TextStyle(
          inherit: false,
          color: iconColor,
          fontFamily: iconData.fontFamily,
          fontFamilyFallback: iconData.fontFamilyFallback,
          fontPackage: iconData.fontPackage,
          fontSize: iconSize,
          height: 1.0,
          shadows: shadows,
        ),
      );

      if (iconData.matchTextDirection) {
        final textDirection = this.textDirection ?? Directionality.of(context);
        if (textDirection == TextDirection.rtl) {
          secondaryIcon = Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            child: secondaryIcon,
          );
        }
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          ExcludeSemantics(
            child: Opacity(
              opacity: duotoneSecondaryOpacity * iconOpacity,
              child: secondaryIcon,
            ),
          ),
          super.build(context),
        ],
      );
    }
    return super.build(context);
  }
}
