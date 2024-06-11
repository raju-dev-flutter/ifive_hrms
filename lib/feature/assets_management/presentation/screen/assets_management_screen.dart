import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';

class AssetManagementScreen extends StatefulWidget {
  const AssetManagementScreen({super.key});

  @override
  State<AssetManagementScreen> createState() => _AssetManagementScreenState();
}

class _AssetManagementScreenState extends State<AssetManagementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Assets",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: Dimensions.kPaddingAllMedium,
        itemCount: 5,
        itemBuilder: (_, i) {
          return const AssetRequestedCardUI();
        },
      ),
    );
  }
}

class AssetRequestedCardUI extends StatelessWidget {
  const AssetRequestedCardUI({super.key});

  Color getColor(String label) {
    switch (label) {
      case "INITIATED":
        return appColor.warning600;
      case "APPROVED" || "PARTIALLY_APPROVED":
        return appColor.success600;
      case "REJECT" || "CANCELLED" || "CLOSED":
        return appColor.error600;
    }
    return appColor.gray600;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
        child: Container(
          padding: Dimensions.kPaddingAllMedium,
          decoration: BoxDecoration(
            color: appColor.white,
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
            border: Border(
              left: BorderSide(width: 5, color: getColor("INITIATED")),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF5F5F5).withOpacity(.2),
                blurRadius: 12,
                offset: const Offset(0, 3),
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Asset',
                      style: context.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500, letterSpacing: .5),
                    ),
                  ),
                  leaveTag(context,
                      label: "INITIATED", color: getColor("INITIATED")),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              Row(
                children: [
                  Text("HR Asset" ?? '',
                      style: context.textTheme.labelMedium
                          ?.copyWith(letterSpacing: .8)),
                  Dimensions.kHorizontalSpaceSmall,
                  SizedBox(
                      width: 10.w, child: Divider(color: appColor.gray700)),
                  Dimensions.kHorizontalSpaceSmall,
                  Text("Access Card" ?? '',
                      style: context.textTheme.labelMedium
                          ?.copyWith(letterSpacing: .8)),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              Text(
                "\" It is a long established fact that a reader will be distracted by the readable content. \"",
                style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    letterSpacing: .6,
                    color: appColor.gray500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.white,
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      border: Border.all(width: 1, color: appColor.gray400),
    );
  }

  Widget leaveTag(BuildContext context,
      {required Color color, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4).w,
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.w500, color: color),
      ),
    );
  }
}
