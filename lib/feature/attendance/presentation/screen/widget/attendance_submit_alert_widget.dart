import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';

class AttendanceCheckOutAlert extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const AttendanceCheckOutAlert(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40).w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: Dimensions.kPaddingAllMedium,
                width: context.deviceSize.width,
                decoration: BoxDecoration(
                  color: appColor.brand600,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ).w,
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500, color: appColor.white),
                ),
              ),
              // Dimensions.kVerticalSpaceSmall,
              Container(
                width: context.deviceSize.width,
                padding: Dimensions.kPaddingAllMedium,
                decoration: BoxDecoration(
                  color: appColor.gray50,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ).w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dimensions.kVerticalSpaceSmallest,
                    Text('Day Summery', style: context.textTheme.labelLarge),
                    Dimensions.kVerticalSpaceSmallest,
                    TextFormField(
                      // autofocus: true,
                      controller: controller,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      obscureText: false,
                      enableInteractiveSelection: true,
                      style: context.textTheme.bodySmall,
                      maxLines: 4,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: appColor.gray700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Color(0xFF61A9FB)),
                        ),
                        labelStyle: context.textTheme.bodySmall,
                        contentPadding: Dimensions.kPaddingAllSmall,
                        errorStyle: context.textTheme.labelMedium
                            ?.copyWith(color: appColor.error600),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(
                            "CANCEL",
                            style: context.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: appColor.error600),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            label,
                            style: context.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: appColor.success600),
                          ),
                        ),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
