import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../../feature.dart';
import '../../../account.dart';

class ProfileEditStream {
  late TextEditingController firstName = TextEditingController();
  late TextEditingController lastName = TextEditingController();
  late TextEditingController phoneNumber = TextEditingController();
  late TextEditingController email = TextEditingController();

  // late TextEditingController bloodGroup = TextEditingController();

  final _dateOfBirth = BehaviorSubject<DateTime?>();

  final _selectDateOfBirth = BehaviorSubject<String>();

  ValueStream<DateTime?> get dateOfBirth => _dateOfBirth.stream;

  ValueStream<String> get selectDateOfBirth => _selectDateOfBirth.stream;

  final _bloodGroupList = BehaviorSubject<List<CommonList>>.seeded([]);

  final _bloodGroupListInit = BehaviorSubject<CommonList>();

  Stream<List<CommonList>> get bloodGroupList => _bloodGroupList.stream;

  ValueStream<CommonList> get bloodGroupListInit => _bloodGroupListInit.stream;

  Future<void> fetchInitialCallBack(Profile profile) async {
    firstName = TextEditingController(text: profile.firstName ?? "");
    lastName = TextEditingController(text: profile.lastName ?? "");
    phoneNumber = TextEditingController(
        text: profile.workTelephoneNumber.toString() != "null"
            ? profile.workTelephoneNumber.toString()
            : "");
    email = TextEditingController(text: profile.email ?? "");

    // final bloodGroupResponse = await _bloodGroupListUserCase();
    // bloodGroupResponse.fold(
    //   (l) => {_bloodGroupList.sink.add([])},
    //   (bloodGroup) {
    //     if (bloodGroup.bloodGroup!.isNotEmpty) {
    //       _bloodGroupList.sink.add(bloodGroup.bloodGroup ?? []);
    //     } else {
    //       _bloodGroupList.sink.add([]);
    //     }
    //   },
    // );

    // bloodGroup = TextEditingController(text: profile.bloodGroup ?? "");

    _selectDateOfBirth.sink.add(profile.dateOfBirth ?? "");
  }

  void selectedDateOfBirth(DateTime date) {
    _dateOfBirth.sink.add(date);
    _selectDateOfBirth.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void bloodGroup(val) {
    _bloodGroupListInit.sink.add(CommonList(id: val.value, name: val.name));
  }

  void onSubmit(BuildContext context) {
    final profileEdit = ProfileEditEvent(body: {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "mobile_number": phoneNumber.text,
      "email": email.text,
      "blood_group": 0,
      "date_of_birth": _selectDateOfBirth.valueOrNull ?? "",
    });

    Logger().i("Submit: $profileEdit");

    BlocProvider.of<AccountCrudBloc>(context).add(profileEdit);
  }
}
