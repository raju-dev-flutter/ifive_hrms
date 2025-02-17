import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifive_hrms/config/config.dart';
import 'package:intl/intl.dart';

class CustomMonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime selectedDate) onDateSelected;

  const CustomMonthYearPicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<CustomMonthYearPicker> createState() => _CustomMonthYearPickerState();
}

class _CustomMonthYearPickerState extends State<CustomMonthYearPicker> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;
  bool isYearSelectionMode = false;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;
  }

  void _selectMonth(int month) {
    setState(() {
      selectedMonth = month;
    });
    widget.onDateSelected(DateTime(selectedYear, selectedMonth, selectedDay));
  }

  void _changeYear(int offset) {
    setState(() {
      selectedYear += offset;
    });
  }

  void _selectYear(int year) {
    setState(() {
      selectedYear = year;
      isYearSelectionMode = false;
    });
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
              height: 100.h,
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: appColor.brand600,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.w),
                  topRight: Radius.circular(16.w),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SELECT MONTH/YEAR",
                    style: context.textTheme.labelMedium
                        ?.copyWith(letterSpacing: 1, color: appColor.white),
                  ),
                  Dimensions.kSpacer,
                  Text(
                    DateFormat('MMMM - yyyy')
                        .format(DateTime(selectedYear, selectedMonth)),
                    style: context.textTheme.bodyLarge?.copyWith(
                        letterSpacing: 1,
                        color: appColor.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              width: context.deviceSize.width,
              height: 360.h,
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: appColor.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.w),
                  bottomRight: Radius.circular(16.w),
                ),
              ),
              child: isYearSelectionMode
                  ? _buildYearSelection()
                  : _buildMonthSelection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearSelection() {
    final years = List.generate(
      widget.lastDate.year - widget.firstDate.year + 1,
      (index) => widget.firstDate.year + index,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: years.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              maxCrossAxisExtent: 80,
            ),
            itemBuilder: (context, index) {
              final year = years[index];
              final isSelected = selectedYear == year;

              return GestureDetector(
                onTap: () => _selectYear(year),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? appColor.brand600 : appColor.white,
                    borderRadius: Dimensions.kBorderRadiusAllLargest,
                    border: isSelected
                        ? Border.all(color: appColor.brand700, width: 1)
                        : Border.all(color: appColor.transparent),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    year.toString(),
                    style: context.textTheme.labelLarge?.copyWith(
                        letterSpacing: 1,
                        color: isSelected ? appColor.white : appColor.gray800,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
          ),
        ),
        Dimensions.kVerticalSpaceSmaller,
        _buildBottomButton(),
      ],
    );
  }

  Widget _buildMonthSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => isYearSelectionMode = true),
              child: Row(
                children: [
                  Text(
                    selectedYear.toString(),
                    style: context.textTheme.labelLarge
                        ?.copyWith(letterSpacing: 1),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Icon(
                    Icons.arrow_drop_down,
                    size: Dimensions.iconSizeSmallest,
                  ),
                ],
              ),
            ),
            Dimensions.kSpacer,
            IconButton(
              onPressed: selectedYear > widget.firstDate.year
                  ? () => _changeYear(-1)
                  : null,
              icon: Icon(
                Icons.arrow_back_ios,
                size: Dimensions.iconSizeSmallest,
              ),
            ),
            IconButton(
              onPressed: selectedYear < widget.lastDate.year
                  ? () => _changeYear(1)
                  : null,
              icon: Icon(
                Icons.arrow_forward_ios,
                size: Dimensions.iconSizeSmallest,
              ),
            ),
          ],
        ),
        Dimensions.kVerticalSpaceSmaller,
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              maxCrossAxisExtent: 80,
            ),
            itemBuilder: (context, index) {
              final month = index + 1;
              final isSelected = selectedMonth == month;
              final isDisabled =
                  DateTime(selectedYear, month).isBefore(widget.firstDate) ||
                      DateTime(selectedYear, month).isAfter(widget.lastDate);

              return GestureDetector(
                onTap: isDisabled ? null : () => _selectMonth(month),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? appColor.brand600
                        : isDisabled
                            ? appColor.gray300
                            : appColor.white,
                    borderRadius: Dimensions.kBorderRadiusAllLargest,
                    border: isSelected
                        ? Border.all(color: appColor.brand700, width: 1)
                        : Border.all(color: appColor.transparent),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _monthName(month),
                    style: context.textTheme.labelLarge?.copyWith(
                        letterSpacing: 1,
                        color: isSelected ? appColor.white : appColor.gray800,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              );
            },
          ),
        ),
        Dimensions.kVerticalSpaceSmaller,
        _buildBottomButton(),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Row(
      children: [
        Dimensions.kSpacer,
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "CANCEL",
            style: context.textTheme.labelLarge
                ?.copyWith(letterSpacing: 1, color: appColor.brand600),
          ),
        ),
        TextButton(
          onPressed: () => _selectMonth(selectedMonth),
          child: Text(
            "OK",
            style: context.textTheme.labelLarge
                ?.copyWith(letterSpacing: 1, color: appColor.brand600),
          ),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return monthNames[month - 1];
  }
}
