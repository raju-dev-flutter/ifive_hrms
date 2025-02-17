import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../config/config.dart';
import '../core/core.dart';
import '../feature/feature.dart';
import '../localization/localization.dart';
import 'app.dart';

class IFiveHrmsApp extends StatefulWidget {
  const IFiveHrmsApp({super.key});

  @override
  State<IFiveHrmsApp> createState() => _IFiveHrmsAppState();
}

class _IFiveHrmsAppState extends State<IFiveHrmsApp> {
  LocalNotificationServices localNotificationServices =
      LocalNotificationServices();

  @override
  void initState() {
    super.initState();

    localNotificationServices.requestNotificationPermission();
    localNotificationServices.firebaseInit(context);
    localNotificationServices.setupInteractMessage(context);

    localNotificationServices.getDeviceToken().then((token) {
      setState(() => Logger().i("Device Token: $token"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (ctx, child) {
        return MaterialApp(
          title: 'IFIVE HRMS',
          navigatorKey: NavigatorService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: GeneratorTheme.lightTheme,
          supportedLocales: const [Locale('en')],
          localizationsDelegates: const [
            AppLocalizationDelegate(),
            // MonthYearPickerLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onGenerateRoute: AppRouter.generateRoute,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                return const SplashScreen();
              }
              if (state is AppPermissionNotGranted) {
                return const PermissionRequestScreen();
              }
              if (state is AuthenticationUnauthenticated) {
                return const LoginScreen();
              }
              if (state is AuthenticationAuthenticated) {
                return const RootScreen();
              }
              return const UnknownScreen();
            },
          ),
        );
      },
    );
  }
}
