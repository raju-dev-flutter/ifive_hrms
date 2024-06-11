import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class AlertChooseTypeDialog extends StatefulWidget {
  final TextEditingController type;
  const AlertChooseTypeDialog({super.key, required this.type});

  @override
  State<AlertChooseTypeDialog> createState() => _AlertChooseTypeDialogState();
}

class _AlertChooseTypeDialogState extends State<AlertChooseTypeDialog> {
  bool isTeaBreak = false;
  bool isLunchBreak = false;
  bool isPersonalBreak = false;
  bool isDayEnd = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40).w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  "Choose Type",
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
                  children: [
                    choose(
                      value: isTeaBreak,
                      label: "Tea/short Break",
                      onChanged: (val) {
                        setState(() {
                          widget.type.text = val! == true ? '1' : '0';
                          isTeaBreak = val;
                          isLunchBreak = false;
                          isPersonalBreak = false;
                          isDayEnd = false;
                        });
                      },
                    ),
                    choose(
                      value: isLunchBreak,
                      label: "Lunch Break",
                      onChanged: (val) {
                        setState(() {
                          widget.type.text = val! == true ? '2' : '0';
                          isTeaBreak = false;
                          isLunchBreak = val;
                          isPersonalBreak = false;
                          isDayEnd = false;
                        });
                      },
                    ),
                    choose(
                      value: isPersonalBreak,
                      label: "Personal Break",
                      onChanged: (val) {
                        setState(() {
                          widget.type.text = val! == true ? '3' : '0';
                          isTeaBreak = false;
                          isLunchBreak = false;
                          isPersonalBreak = val;
                          isDayEnd = false;
                        });
                      },
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Row(
                      children: [
                        Dimensions.kHorizontalSpaceMedium,
                        Expanded(
                          child: ActionButton(
                            height: 40,
                            onPressed: () => {
                              widget.type.text = '0',
                              Navigator.pop(context)
                            },
                            color: appColor.error600,
                            child: Text(
                              "CANCEL",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodySmall
                                  ?.copyWith(color: appColor.white),
                            ),
                          ),
                        ),
                        Dimensions.kHorizontalSpaceSmall,
                        Expanded(
                          child: ActionButton(
                            height: 40,
                            onPressed: () => Navigator.pop(context),
                            color: appColor.success600,
                            child: Text(
                              "YES",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodySmall
                                  ?.copyWith(color: appColor.white),
                            ),
                          ),
                        ),
                        Dimensions.kHorizontalSpaceMedium,
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmall,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget choose(
      {required bool value,
      required String label,
      required void Function(bool?)? onChanged}) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(
          label,
          textAlign: TextAlign.center,
          style: context.textTheme.labelLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
