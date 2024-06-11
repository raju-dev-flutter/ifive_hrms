part of 'account_details_cubit.dart';

sealed class AccountDetailsState extends Equatable {
  const AccountDetailsState();

  @override
  List<Object> get props => [];
}

final class AccountDetailsInitial extends AccountDetailsState {
  const AccountDetailsInitial();
}

class AccountDetailsLoading extends AccountDetailsState {
  const AccountDetailsLoading();
}

class AccountDetailsLoaded extends AccountDetailsState {
  final ProfileDetailModel profile;
  const AccountDetailsLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class AccountDetailsFailed extends AccountDetailsState {
  final String message;

  const AccountDetailsFailed({required this.message});

  @override
  List<Object> get props => [];
}
