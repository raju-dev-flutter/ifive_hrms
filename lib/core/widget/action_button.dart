import 'package:flutter/material.dart';

import '../../config/config.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? label;
  final double? width;
  final double? height;
  final Color? color;
  const ActionButton(
      {super.key,
      required this.onPressed,
      this.child,
      this.label,
      this.height,
      this.color,
      this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        height: height ?? 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
                  color: appColor.white,
                  letterSpacing: .6,
                  fontWeight: FontWeight.w500),
            ),
      ),
    );
  }
}

class DefaultActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? height;
  const DefaultActionButton(
      {super.key, this.onPressed, required this.label, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
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
      ),
    );
  }
}
