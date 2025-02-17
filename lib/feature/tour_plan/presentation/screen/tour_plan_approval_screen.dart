import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';

class TourPlanApprovalScreen extends StatefulWidget {
  const TourPlanApprovalScreen({super.key});

  @override
  State<TourPlanApprovalScreen> createState() => _TourPlanApprovalScreenState();
}

class _TourPlanApprovalScreenState extends State<TourPlanApprovalScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Tour Plan Approval",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6).w,
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            obscureText: false,
            enableInteractiveSelection: true,
            style: context.textTheme.bodySmall,
            onChanged: (val) {},
            decoration: inputDecoration(label: 'Search', onPressed: () {}),
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemBuilder: (_, i) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      _, AppRouterPath.tourPlanApprovalFormScreen);
                },
                borderRadius: Dimensions.kBorderRadiusAllSmaller,
                child: Container(
                  padding: Dimensions.kPaddingAllMedium,
                  decoration: BoxDecoration(
                    color: appColor.white,
                    borderRadius: Dimensions.kBorderRadiusAllSmaller,
                    boxShadow: [
                      BoxShadow(
                        color: appColor.gray300.withOpacity(.2),
                        offset: const Offset(0, 3),
                        blurRadius: 12,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: Dimensions.iconSizeSmallest),
                          Dimensions.kHorizontalSpaceSmaller,
                          Text(
                            "TEST USER - IFT-101",
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month,
                              size: Dimensions.iconSizeSmallest),
                          Dimensions.kHorizontalSpaceSmaller,
                          Text(
                            "05 | 05-01-2025",
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, i) {
              return Dimensions.kVerticalSpaceSmaller;
            },
            itemCount: 10,
          ),
        ),
      ],
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
        borderSide: BorderSide(color: appColor.blue100),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      labelText: "$label...",
      labelStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error400),
    );
  }
}
