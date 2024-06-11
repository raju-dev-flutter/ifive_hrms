part of 'widget.dart';

class IconGroupModel {
  final String label;
  final String icon;
  final Color? color;

  const IconGroupModel({required this.label, required this.icon, this.color});
}

class DashboardLeaveWidget extends StatelessWidget {
  const DashboardLeaveWidget({super.key});

  static List<IconGroupModel> pages = [
    IconGroupModel(
      icon: AppSvg.leaveAdd,
      label: 'Request Leave',
      color: appColor.blue600,
    ),
    IconGroupModel(
      icon: AppSvg.leaveApproval,
      label: 'Leave Approval',
      color: appColor.warning600,
    ),
    IconGroupModel(
      icon: AppSvg.leaveHistory,
      label: 'Leave History',
      color: appColor.success600,
    ),
  ];

  void gotoNextPage(BuildContext _, String label) {
    switch (label) {
      case "Request Leave":
        Navigator.pushNamed(_, AppRouterPath.leaveRequest);
        break;
      case "Leave Approval":
        Navigator.pushNamed(_, AppRouterPath.leaveApproval);
        break;
      case "Leave History":
        Navigator.pushNamed(_, AppRouterPath.leaveHistory);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0).w,
      height: 94.h,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / .7,
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(0),
        itemCount: pages.length,
        itemBuilder: (_, i) {
          return InkWell(
            onTap: () => gotoNextPage(context, pages[i].label),
            borderRadius: BorderRadius.circular(8).w,
            child: Container(
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).w,
                color: appColor.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0800366D),
                    offset: Offset(0, 3),
                    spreadRadius: 3,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      pages[i].icon,
                      width: 20.w,
                      colorFilter: ColorFilter.mode(
                        pages[i].color!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text(
                    pages[i].label,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelSmall?.copyWith(
                        color: pages[i].color!, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DashboardServiceWidget extends StatelessWidget {
  const DashboardServiceWidget({super.key});

  static const List<IconGroupModel> pages = [
    IconGroupModel(
      icon: AppSvg.attendance,
      label: 'Attendance',
      color: Color(0xFF16A34A),
    ),
    IconGroupModel(
      icon: AppSvg.foodFill,
      label: 'Food Attendance',
      color: Color(0xFFEA580C),
    ),
    IconGroupModel(
      icon: AppSvg.missPunch,
      label: 'Misspunch',
      color: Color(0xFFDB2777),
    ),
    IconGroupModel(
      icon: AppSvg.leave,
      label: 'OD | Permission',
      color: Color(0xFF9333EA),
    ),
    IconGroupModel(
      icon: AppSvg.payroll,
      label: 'Payroll',
      color: Color(0xFF4F46E5),
    ),
    IconGroupModel(
      icon: AppSvg.asset,
      label: 'Expenses',
      color: Color(0xFFD44F37),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16).w,
      child: Wrap(
        runSpacing: 6.w,
        spacing: 6.w,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          for (var page in pages) ...[
            InkWell(
              onTap: () => gotoNextPage(context, page.label),
              borderRadius: BorderRadius.circular(8).w,
              child: Container(
                width: 168.w,
                height: 70.h,
                padding: Dimensions.kPaddingAllMedium,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).w,
                  color: appColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: appColor.gray200.withOpacity(.4),
                      offset: const Offset(0, 3),
                      spreadRadius: 3,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        page.icon,
                        width: 30.w,
                        colorFilter:
                            ColorFilter.mode(page.color!, BlendMode.srcIn),
                      ),
                    ),
                    Dimensions.kHorizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            page.label,
                            style: context.textTheme.labelMedium?.copyWith(
                                color: appColor.gray600,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void gotoNextPage(BuildContext _, String label) {
    switch (label) {
      case "Attendance":
        Navigator.pushNamed(_, AppRouterPath.attendance);
        break;
      case "Misspunch":
        Navigator.pushNamed(_, AppRouterPath.misspunch);
        break;
      case "Food Attendance":
        Navigator.pushNamed(_, AppRouterPath.foodAttendance);
        break;
      case "OD | Permission":
        Navigator.pushNamed(_, AppRouterPath.oDPermissionScreen);
        break;
      case "Payroll":
        Navigator.pushNamed(_, AppRouterPath.payrollScreen);
        break;
      case "Expenses":
        Navigator.pushNamed(_, AppRouterPath.expensesScreen);
        break;
      case "Assets":
        Navigator.pushNamed(_, AppRouterPath.assetManagementScreen);
        break;
    }
  }
}
