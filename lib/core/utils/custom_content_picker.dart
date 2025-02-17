import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';
import '../core.dart';

class CustomContentPicker extends StatefulWidget {
  final String label;
  final CommonList initialData;
  final List<CommonList> streamList;
  final bool isSearch;
  final double? height;
  final void Function(CommonList data) onChanged;

  const CustomContentPicker(
      {super.key,
      required this.label,
      required this.initialData,
      required this.streamList,
      required this.onChanged,
      this.height,
      required this.isSearch});

  @override
  State<CustomContentPicker> createState() => _CustomContentPickerState();
}

class _CustomContentPickerState extends State<CustomContentPicker> {
  late CommonList? selectedCommonList;

  final searchController = TextEditingController();
  late List<CommonList> filterCommonList = [];

  @override
  void initState() {
    super.initState();
    selectedCommonList = widget.initialData;
    initiatingFilter("", widget.streamList);
    setState(() {});
  }

  void initiatingFilter(String filter, List<CommonList> data) {
    filterCommonList = data.where((d) {
      return d.name!.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    setState(() {});
  }

  void _selectCommonList(CommonList data) {
    setState(() {
      selectedCommonList = data;
    });
    widget.onChanged(selectedCommonList ?? widget.initialData);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16).w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: context.deviceSize.width,
              padding: Dimensions.kPaddingAllSmall,
              decoration: BoxDecoration(
                color: appColor.brand600,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.w),
                  topRight: Radius.circular(16.w),
                ),
              ),
              child: Column(
                crossAxisAlignment: widget.isSearch
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    style: context.textTheme.labelMedium
                        ?.copyWith(letterSpacing: 1, color: appColor.white),
                  ),
                  if (widget.isSearch) ...[
                    Dimensions.kVerticalSpaceSmall,
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      obscureText: false,
                      enableInteractiveSelection: true,
                      style: context.textTheme.bodySmall,
                      onChanged: (val) =>
                          initiatingFilter(val, widget.streamList),
                      scrollPadding: Dimensions.kPaddingAllSmaller,
                      decoration: inputDecoration(
                        label: 'Search',
                        onPressed: () => initiatingFilter(
                            searchController.text, widget.streamList),
                      ),
                    )
                  ]
                ],
              ),
            ),
            Container(
              width: context.deviceSize.width,
              height: widget.height ?? 350.h,
              decoration: BoxDecoration(
                color: appColor.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.w),
                  bottomRight: Radius.circular(16.w),
                ),
              ),
              child: ListView.separated(
                itemCount: filterCommonList.length,
                separatorBuilder: (_, i) {
                  return Dimensions.kDivider;
                },
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () => _selectCommonList(filterCommonList[i]),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                      decoration: BoxDecoration(
                        color: appColor.white,
                        borderRadius: Dimensions.kBorderRadiusAllLargest,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        filterCommonList[i].name ?? "",
                        style: context.textTheme.labelLarge?.copyWith(
                          letterSpacing: 1,
                          color: appColor.gray800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(
      {required String label, required Function() onPressed}) {
    return InputDecoration(
      suffixIcon: InkWell(
        onTap: onPressed,
        child: Icon(Icons.search, color: appColor.gray400),
      ),
      fillColor: appColor.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.blue600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      hintText: "$label...",
      hintStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray400),
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error400),
    );
  }
}
