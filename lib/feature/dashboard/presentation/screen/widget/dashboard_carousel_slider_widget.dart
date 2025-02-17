part of 'widget.dart';

class DashboardCarouselSlider extends StatelessWidget {
  const DashboardCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AppreciationCubit>(context, listen: false)
        .getAppreciation();
    return BlocBuilder<AppreciationCubit, AppreciationState>(
      builder: (context, state) {
        if (state is AppreciationLoaded) {
          if (state.appreciation.announcement!.isEmpty) {
            return Container();
          }
          return CarouselSlider.builder(
              itemCount: state.appreciation.announcement!.length,
              itemBuilder: (BuildContext context, int i, int pageViewIndex) =>
                  AppreciationWidget(
                      announcement: state.appreciation.announcement![i]),
              options: CarouselOptions(
                height: 150,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ));
        }
        if (state is AppreciationLoading) {
          return Container();
        }
        if (state is AppreciationFailed) {
          return Container();
        }
        return Container();
      },
    );
  }
}

class AppreciationWidget extends StatelessWidget {
  final AnnouncementResponse announcement;

  const AppreciationWidget({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final isProfileNotEmpty =
        announcement.photo != "" && announcement.photo != null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 0).w,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30).w,
            width: context.deviceSize.width,
            height: context.deviceSize.height,
            padding: Dimensions.kPaddingAllMedium,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appColor.white,
              borderRadius: Dimensions.kBorderRadiusAllSmaller,
              boxShadow: [
                BoxShadow(
                  color: appColor.gray300.withOpacity(.2),
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getAnnouncement(announcement).toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelLarge?.copyWith(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: appColor.brand800),
                ),
              ],
            ),
          ),
          Container(
            width: 54,
            height: 54,
            padding: Dimensions.kPaddingAllSmall,
            decoration: BoxDecoration(
              color: isProfileNotEmpty ? null : appColor.white,
              borderRadius: Dimensions.kBorderRadiusAllLarger,
              image: isProfileNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(
                          "${ApiUrl.baseUrl}public/images/profile_images/${announcement.photo}"),
                      fit: BoxFit.cover,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: appColor.gray300.withOpacity(.2),
                  offset: const Offset(0, -3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: isProfileNotEmpty
                ? null
                : SvgPicture.asset(
                    AppSvg.accountFill,
                    colorFilter:
                        ColorFilter.mode(appColor.brand800, BlendMode.srcIn),
                  ),
          ),
          if (announcement.tp != "master") ...[
            Positioned(
              bottom: 0,
              child: Lottie.asset(AppLottie.animationTwo, height: 150),
            ),
            Positioned(
              left: -55,
              bottom: -56,
              child: Lottie.asset(AppLottie.animationOne, height: 150),
            ),
            Positioned(
              right: -55,
              bottom: -56,
              child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Lottie.asset(AppLottie.animationOne, height: 150)),
            ),
          ]
        ],
      ),
    );
  }

  String getAnnouncement(AnnouncementResponse announcement) {
    switch (announcement.tp) {
      case 'dob':
        return 'Happy Birthday ${announcement.empName}';
      case 'doj':
        return 'Happy Work Anniversary ${announcement.empName}';
      case 'master':
        return '${announcement.text}';
      default:
        return '${announcement.text}';
    }
  }
}
