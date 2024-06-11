import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required Login login, required ChangePassword changePassword})
      : _login = login,
        _changePassword = changePassword,
        super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(const LoginLoading());

      final result = await _login(LoginParams(
        user: event.user,
        password: event.password,
        latitude: event.latitude,
        longitude: event.longitude,
        geoAddress: event.geoAddress,
        battery: event.battery,
        imei: event.imei,
      ));

      result.fold((failure) => emit(LoginFailed(failure.errorMessage)),
          (response) {
        SharedPrefs().setLoginResponse(response);
        // serviceStart(response),
        emit(const LoginSuccess());
      });
    });
    on<ChangePasswordEvent>((event, emit) async {
      emit(const ChangePasswordLoading());

      final result =
          await _changePassword(PasswordParams(password: event.password));

      result.fold((_) => emit(ChangePasswordFailed(_.errorMessage)),
          (_) => emit(const ChangePasswordSuccess()));
    });
  }

  late MethodChannel methodChannel;
  String nameOfTheChannel = AppKeys.methodChannel;
  final Login _login;
  final ChangePassword _changePassword;

// Future<void> serviceStart(LoginResponse response) async {
//   Logger().i('Service Calling');
//   try {
//     methodChannel = MethodChannel(nameOfTheChannel);
//     var result = await methodChannel.invokeMethod(
//         "alarm_run", <String, dynamic>{'token': response.token});
//     if (result == "Success") {
//       // userRepositories.setmethodChannel(result);
//     }
//   } catch (e) {
//     Logger().e("Error while accessing native call");
//   }
// }
}
