import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordShow = false;

  String geoAddress = '';
  double latitude = 0;
  double longitude = 0;

  final methodChannel = const MethodChannel(AppKeys.methodChannel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFCFDFE),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            _emailController.clear();
            _passwordController.clear();
            alarmRun();
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedIn());
          }

          if (state is LoginFailed) {
            AppAlerts.displayWarningAlert(context, "Login", state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                SizedBox(
                  height: context.deviceSize.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Image(
                            image: const AssetImage(AppIcon.ifiveLogo),
                            width: 140.w,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [appColor.brand600, appColor.brand800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: SizedBox(
                    width: context.deviceSize.width,
                    height: context.deviceSize.height,
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: Dimensions.kPaddingAllMedium,
                            child: Container(
                              width: context.deviceSize.width,
                              decoration: BoxDecoration(
                                color: appColor.white,
                                borderRadius: Dimensions.kBorderRadiusAllSmall,
                                boxShadow: [
                                  BoxShadow(
                                    color: appColor.gray600.withOpacity(.2),
                                    offset: const Offset(3, 0),
                                    blurRadius: 12,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              padding: Dimensions.kPaddingAllLarger,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Dimensions.kVerticalSpaceSmall,
                                  Text(
                                    'Welcome',
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.displayMedium
                                        ?.copyWith(color: appColor.gray700),
                                  ),
                                  Dimensions.kVerticalSpaceSmallest,
                                  Text(
                                    'Please log in to access your account.',
                                    style: context.textTheme.labelMedium
                                        ?.copyWith(color: appColor.gray900),
                                  ),
                                  Dimensions.kVerticalSpaceMedium,
                                  loginFormBoxUI(),
                                  Dimensions.kSpacer,
                                  authActionButton(),
                                  Dimensions.kVerticalSpaceLarge,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Dimensions.kVerticalSpaceLarge,
                        // Dimensions.kSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Powered by: ',
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: appColor.white),
                            ),
                            const Image(
                              image: AssetImage(AppIcon.ifiveLogo),
                              width: 20,
                            ),
                            Text(
                              'I Five Technology Pvt Ltd.',
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: appColor.white),
                            ),
                          ],
                        ),
                        Dimensions.kVerticalSpaceMedium,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget loginFormBoxUI() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dimensions.kVerticalSpaceSmall,
          Text(
            "User Name",
            style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: appColor.gray900.withOpacity(.7)),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: _emailController,
            enableSuggestions: true,
            obscureText: false,
            enableInteractiveSelection: true,
            keyboardType: TextInputType.text,
            decoration: inputDecoration(label: 'Username'),
            style: context.textTheme.bodySmall,
            autofillHints: const [AutofillHints.username],
            validator: (user) {
              if (!isCheckTextFieldIsEmpty(user!)) {
                return "Please enter your valid user";
              } else {
                return null;
              }
            },
          ),
          Dimensions.kVerticalSpaceSmall,
          Text(
            "Password",
            style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: appColor.gray900.withOpacity(.7)),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
            decoration: inputDecoration(label: 'Password'),
            obscureText: !_isPasswordShow,
            enableSuggestions: true,
            enableInteractiveSelection: true,
            style: context.textTheme.bodySmall,
            autofillHints: const [AutofillHints.password],
            validator: (password) {
              if (!isPasswordValid(password!)) {
                return "Please enter your valid password";
              } else {
                return null;
              }
            },
          ),
          Dimensions.kVerticalSpaceLarger,
        ],
      ),
    );
  }

  InputDecoration inputDecoration({required String label}) {
    final isPassword = label == "Password";
    return InputDecoration(
      suffixIcon: isPassword
          ? GestureDetector(
              onTap: () => setState(() => _isPasswordShow = !_isPasswordShow),
              child: Icon(
                _isPasswordShow ? Icons.lock_open : Icons.lock,
                size: 20,
                color:
                    _isPasswordShow ? appColor.gray900 : Colors.grey.shade500,
              ),
            )
          : null,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColor.gray600),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColor.brand600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColor.brand600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColor.error600),
      ),
      // labelText: label,
      hintText: label,
      hintStyle:
          context.textTheme.labelLarge?.copyWith(color: appColor.gray500),
      labelStyle:
          context.textTheme.labelLarge?.copyWith(color: appColor.gray500),
      contentPadding: Dimensions.kPaddingAllMedium,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error600),
    );
  }

  authActionButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return Center(
              child: CircularProgressIndicator(color: appColor.brand600));
        }
        return InkWell(
          onTap: onSubmit,
          child: Container(
            width: context.deviceSize.width,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [appColor.brand600, appColor.brand800]),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF78D7FA).withOpacity(.2),
                  blurRadius: 12,
                  spreadRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Log in',
              style:
                  context.textTheme.titleLarge?.copyWith(color: appColor.white),
            ),
          ),
        );
      },
    );
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
        geoAddress = '${place[0].subLocality}, ${place[0].locality}';
        latitude = position.latitude;
        longitude = position.longitude;
      });
    }
  }

  dynamic getBattery() async {
    try {
      var battery =
          await methodChannel.invokeMethod("battery", <String, dynamic>{});
      return battery;
    } catch (e) {
      Logger().e("Error while accessing native call");

      return 0;
    }
  }

  void alarmRun() async {
    try {
      await methodChannel.invokeMethod("alarm_run", <String, dynamic>{});
    } catch (e) {
      Logger().e("Error while accessing native call");
    }
  }

  void onSubmit() async {
    var battery = await getBattery();
    // var imei = await getImei();

    if (_formKey.currentState!.validate()) {
      TextInput.finishAutofillContext();
      context.read<AuthBloc>().add(LoginEvent(
            user: _emailController.text,
            password: _passwordController.text,
            latitude: latitude,
            longitude: longitude,
            geoAddress: geoAddress,
            battery: battery.toString(),
            imei: "0",
          ));
    } else {
      // show a message that form validation failed
      AppAlerts.displaySnackBar(
          context, "Please enter your user details", false);
    }
  }
}
