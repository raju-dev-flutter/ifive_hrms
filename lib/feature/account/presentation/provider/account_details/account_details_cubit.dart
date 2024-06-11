import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../account.dart';

part 'account_details_state.dart';

class AccountDetailsCubit extends Cubit<AccountDetailsState> {
  AccountDetailsCubit({required ProfileDetail profileDetail})
      : _profileDetail = profileDetail,
        super(initialState());

  static initialState() => const AccountDetailsInitial();

  final ProfileDetail _profileDetail;

  void getAccountDetails() async {
    emit(const AccountDetailsLoading());
    final response = await _profileDetail();
    response.fold(
      (_) => emit(AccountDetailsFailed(message: _.message)),
      (__) => emit(AccountDetailsLoaded(profile: __)),
    );
  }
}
