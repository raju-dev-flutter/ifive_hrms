part of 'widget.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final Widget? actionWidget;

  const DashboardHeaderWidget(
      {super.key, required this.scaffold, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    // final isCheckImageEmpty =
    //     SharedPrefs.instance.getString(AppKeys.profile) != "" &&
    //         SharedPrefs.instance.getString(AppKeys.profile) != "null" &&
    //         SharedPrefs.instance.getString(AppKeys.profile) != null;
    return Container(
      width: context.deviceSize.width,
      decoration: BoxDecoration(color: appColor.brand800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
            builder: (context, state) {
              if (state is AccountDetailsLoading) {
                return Padding(
                  padding: Dimensions.kPaddingAllMedium,
                  child: const AccountHeaderShimmerLoading(),
                );
              }
              if (state is AccountDetailsLoaded) {
                final profile = state.profile.profile;
                final isCheckImageEmpty = profile!.avatar != "" &&
                    profile.avatar != "null" &&
                    profile.avatar != null;
                return Container(
                  padding: Dimensions.kPaddingAllMedium,
                  child: Row(
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.h,
                        padding: const EdgeInsets.all(12).w,
                        decoration: BoxDecoration(
                          color: isCheckImageEmpty ? null : appColor.gray50,
                          borderRadius: Dimensions.kBorderRadiusAllLarge,
                          border: Border.all(
                            color: appColor.gray300,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          image: isCheckImageEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  image: NetworkImage(
                                      "${ApiUrl.baseUrl}public/${profile.avatar}"))
                              : null,
                        ),
                        child: isCheckImageEmpty
                            ? null
                            : SvgPicture.asset(
                                AppSvg.accountFill,
                                colorFilter: ColorFilter.mode(
                                    appColor.brand700, BlendMode.srcIn),
                              ),
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${profile.firstName ?? ""} ${profile.lastName ?? ""}",
                            style: context.textTheme.titleMedium?.copyWith(
                              color: appColor.white,
                            ),
                          ),
                          Text(
                            profile.email ?? "",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: appColor.white,
                            ),
                          ),
                        ],
                      ),
                      Dimensions.kSpacer,
                      if (actionWidget != null) ...[
                        actionWidget ?? Dimensions.kSizedBox,
                        Dimensions.kHorizontalSpaceSmall,
                      ],
                      GestureDetector(
                        onTap: () => scaffold.currentState!.openDrawer(),
                        child: SvgPicture.asset(
                          AppSvg.menuFull,
                          colorFilter:
                              ColorFilter.mode(appColor.white, BlendMode.srcIn),
                          width: Dimensions.iconSizeSmaller,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
