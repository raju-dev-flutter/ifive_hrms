import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/core.dart';
import '../../config/config.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool required;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(dynamic)? onChanged;
  final int? maxLines;

  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      required this.required,
      this.inputFormatters,
      this.validator,
      this.keyboardType,
      this.readOnly,
      this.onChanged,
      this.maxLines,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "$label ",
            style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400, color: appColor.gray500),
            children: [
              TextSpan(
                text: required == true ? "*" : "",
                style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400, color: appColor.error600),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          enableSuggestions: true,
          obscureText: false,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatters,
          enableInteractiveSelection: true,
          style: context.textTheme.bodySmall,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
          // textAlign: TextAlign.start,
          // textAlignVertical: TextAlignVertical.top,
          decoration: inputDecoration(context, hint ?? ''),
        ),
      ],
    );
  }

  InputDecoration inputDecoration(BuildContext context, String label) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.blue500),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      labelText: label.toUpperCase(),
      labelStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray400),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 12).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error600),
    );
  }
}

class CustomDateTimeTextFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? icon;
  final TextEditingController controller;
  final bool required;
  final String? Function(String?)? validator;
  final Function() onPressed;

  const CustomDateTimeTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      required this.required,
      this.validator,
      required this.onPressed,
      this.hint,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "$label ",
              style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w400, color: appColor.gray500),
              children: [
                TextSpan(
                  text: required == true ? "*" : "",
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400, color: appColor.error600),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(6).w,
            child: IgnorePointer(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                style: context.textTheme.bodySmall,
                validator: validator,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: onPressed,
                    child: Container(
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appColor.gray700,
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(6).w,
                          bottomRight: const Radius.circular(6).w,
                        ),
                      ),
                      child: SvgPicture.asset(
                        icon ?? AppSvg.calendar,
                        width: 17.w,
                        colorFilter:
                            ColorFilter.mode(appColor.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                    borderSide: BorderSide(color: appColor.gray400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                    borderSide: BorderSide(color: appColor.gray400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                    borderSide: BorderSide(color: appColor.brand600),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                    borderSide: BorderSide(color: appColor.error700),
                  ),
                  // labelText: "SELECT DATE",
                  labelText: (hint ?? 'SELECT DATE').toUpperCase(),
                  labelStyle: context.textTheme.labelMedium
                      ?.copyWith(color: appColor.gray400),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0).w,
                  errorStyle: context.textTheme.labelMedium
                      ?.copyWith(color: appColor.error700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
