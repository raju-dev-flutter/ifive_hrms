part of 'widget.dart';

class DashboardDateLocationWidget extends StatefulWidget {
  const DashboardDateLocationWidget({super.key});

  @override
  State<DashboardDateLocationWidget> createState() =>
      _DashboardDateLocationWidgetState();
}

class _DashboardDateLocationWidgetState
    extends State<DashboardDateLocationWidget> {
  String address = '';

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> place = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (mounted) {
      setState(() {
        SharedPrefs().setGeoAddress(position.latitude, position.longitude,
            '${place[0].thoroughfare}, ${place[0].subLocality}, ${place[0].locality}.');
        // address = '${place[0].subLocality}, ${place[0].locality}';
        address =
            '${place[0].thoroughfare}, ${place[0].subLocality}, ${place[0].locality}.';
      });
    }
  }

  String getCurrentDate() {
    final splitDate = DateFormat('yyyy-MM-dd hh:mm')
        .format(DateTime.now())
        .split(' ')[0]
        .split('-');

    int year = int.parse(splitDate[0]);
    int date = int.parse(splitDate[1]);
    int month = int.parse(splitDate[2]);
    DateTime now = DateTime(year, date, month);

    return '${Convert.day(now)}, ${splitDate[2]} ${Convert.month(now)} $year';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16).w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(getCurrentDate(), style: context.textTheme.labelMedium),
          Dimensions.kHorizontalSpaceSmall,
          address == ""
              ? const LocationShimmer()
              : Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
                            .w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appColor.brand900.withOpacity(.1),
                      borderRadius: Dimensions.kBorderRadiusAllMedium,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: appColor.brand900),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            address,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium
                                ?.copyWith(color: appColor.brand900),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class LocationShimmer extends StatelessWidget {
  const LocationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: appColor.gray300.withOpacity(.3),
      highlightColor: appColor.gray300.withOpacity(.3),
      child: Container(
        width: 150,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: Dimensions.kBorderRadiusAllSmallest,
          color: appColor.gray300.withOpacity(.4),
        ),
      ),
    );
  }
}
