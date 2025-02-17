import 'package:flutter/material.dart';

import '../../config/config.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? label;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final Color? textColor;

  const ActionButton({
    super.key,
    required this.onPressed,
    this.child,
    this.label,
    this.height,
    this.radius,
    this.color,
    this.width,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(radius ?? 8),
      child: Container(
        width: width ?? context.deviceSize.width,
        height: height ?? 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: color,
          gradient: color == null
              ? LinearGradient(
                  colors: [appColor.brand700, appColor.brand600],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF61A9FB).withOpacity(.1),
              blurRadius: 12,
              spreadRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child ??
            Text(
              label!,
              style: context.textTheme.labelLarge?.copyWith(
                  color: textColor ?? appColor.white,
                  letterSpacing: .6,
                  fontWeight: FontWeight.w500),
            ),
      ),
    );
  }
}

class DefaultActionButton extends StatelessWidget {
  final String label;
  final double? height;

  const DefaultActionButton({super.key, required this.label, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: appColor.gray100,
        boxShadow: [
          BoxShadow(
            color: appColor.gray100.withOpacity(.1),
            blurRadius: 12,
            spreadRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: context.textTheme.labelLarge
            ?.copyWith(color: appColor.gray600, fontWeight: FontWeight.bold),
      ),
    );
  }
}
