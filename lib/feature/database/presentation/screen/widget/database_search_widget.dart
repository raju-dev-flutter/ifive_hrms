import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';

class DatabaseSearchWidget extends StatelessWidget {
  final Function() onPressed;
  final Function(String) onChanged;
  final TextEditingController controller;

  const DatabaseSearchWidget(
      {super.key,
      required this.onPressed,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 6).w,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        enableSuggestions: true,
        obscureText: false,
        enableInteractiveSelection: true,
        style: context.textTheme.bodySmall,
        onChanged: (val) => onChanged(val),
        decoration: inputDecoration(
          context,
          label: 'Search',
          onPressed: onPressed,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(BuildContext context,
      {required String label, required Function() onPressed}) {
    return InputDecoration(
      suffixIcon: InkWell(
        onTap: onPressed,
        child: const Icon(Icons.search),
      ),
      fillColor: appColor.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.white.withOpacity(.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.blue600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      labelText: "$label...",
      labelStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray600),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error600),
    );
  }
}
