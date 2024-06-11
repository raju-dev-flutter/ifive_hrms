part of 'screen.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const HomeScreen({super.key, required this.scaffold});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Logger().i("User Token: ${SharedPrefs().getToken()}");
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    final token = SharedPrefs().getToken();
    BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
        .getAttendanceStatus(token);
    BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceStatusCubit, AttendanceStatusState>(
      listener: (context, state) {
        if (state is AttendanceStatusFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
          }
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 110.h,
            child: DashboardHeaderWidget(scaffold: widget.scaffold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const DashboardDateLocationWidget(),
                  // const DashboardCarouselSlider(),
                  const DashboardAttendanceStatusWidget(),
                  const DashboardLeaveWidget(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 8).w,
                    child: Container(
                      width: context.deviceSize.width,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8)
                          .w,
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
                      child: Text(
                        'Services',
                        style: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const DashboardServiceWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
