import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../config/config.dart';
import '../core.dart';

class CustomStreamDropDownWidget extends StatelessWidget {
  final String label;
  final Stream<List<CommonList>> streamList;
  final ValueStream<CommonList>? valueListInit;
  final bool? required;
  final bool? readOnly;
  final String? initialData;
  final void Function(dynamic) onChanged;
  final String? Function(String?)? validator;
  const CustomStreamDropDownWidget({
    super.key,
    required this.label,
    required this.streamList,
    this.valueListInit,
    required this.onChanged,
    this.validator,
    this.required,
    this.readOnly,
    this.initialData,
  });

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
                text: required == true && required != null ? "*" : "",
                style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400, color: appColor.error600),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        StreamBuilder<List<CommonList>>(
          stream: streamList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              var initialValue = initialData ??
                  (valueListInit?.valueOrNull?.name != null
                      ? valueListInit?.valueOrNull!.name
                      : "");
              var isEnabled =
                  readOnly != null && readOnly == true ? false : true;
              return DropDownTextField(
                initialValue: initialValue,
                clearOption: false,
                enableSearch: isEnabled,
                textStyle: context.textTheme.bodySmall,
                clearIconProperty: IconProperty(color: Colors.red),
                searchDecoration: const InputDecoration(hintText: "Search"),
                validator: validator,
                isEnabled: isEnabled,
                dropDownItemCount: 4,
                textFieldDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                    borderSide: BorderSide(color: appColor.gray400),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                    borderSide: BorderSide(color: appColor.error700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                    borderSide: BorderSide(color: appColor.blue500),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6).w,
                  ),
                  labelText: "SELECT",
                  labelStyle: context.textTheme.labelMedium
                      ?.copyWith(color: appColor.gray400),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
                          .w,
                  errorStyle: context.textTheme.labelMedium
                      ?.copyWith(color: appColor.error700),
                ),
                dropDownList: data
                    .map((val) =>
                        DropDownValueModel(name: val.name!, value: val.id))
                    .toList(),
                onChanged: onChanged,
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
