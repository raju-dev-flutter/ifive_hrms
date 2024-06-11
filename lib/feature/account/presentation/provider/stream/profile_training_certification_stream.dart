import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

class ProfileTrainingCertificationStream {
  ProfileTrainingCertificationStream(
      {required CertificateLevelUseCase $CertificateLevelUseCase})
      : _$CertificateLevelUseCase = $CertificateLevelUseCase;

  final CertificateLevelUseCase _$CertificateLevelUseCase;

  final _isLoading = BehaviorSubject<bool>.seeded(false);

  late TextEditingController courseName = TextEditingController();
  late TextEditingController certificateName = TextEditingController();
  late TextEditingController courseDuration = TextEditingController();

  final _issuedDate = BehaviorSubject<DateTime?>();

  final _selectIssuedDate = BehaviorSubject<String>();

  final _certificateLevel = BehaviorSubject<List<CommonList>>.seeded([]);
  final _certificateLevelListInit = BehaviorSubject<CommonList>();

  final _file = BehaviorSubject<File?>();

  ValueStream<DateTime?> get issuedDate => _issuedDate.stream;

  ValueStream<bool> get isLoading => _isLoading.stream;

  ValueStream<String> get selectIssuedDate => _selectIssuedDate.stream;

  Stream<List<CommonList>> get certificateLevel => _certificateLevel.stream;

  ValueStream<CommonList> get certificateLevelListInit =>
      _certificateLevelListInit.stream;

  ValueStream<File?> get file => _file.stream;

  Future<void> fetchInitialCallBack() async {
    final response = await _$CertificateLevelUseCase();
    response.fold(
      (_) => {_certificateLevel.add([])},
      (_) {
        if (_.certificateLevel!.isNotEmpty) {
          _certificateLevel.add(_.certificateLevel ?? []);
        }
      },
    );
  }

  void fetchInitialCallBackWithDetail(TrainingCertification? tc) async {
    _isLoading.sink.add(true);

    final response = await _$CertificateLevelUseCase();
    courseName = TextEditingController(text: tc!.courseName ?? '');
    certificateName = TextEditingController(text: tc.certificateName ?? '');
    courseDuration = TextEditingController(text: tc.courseDuration ?? '');

    _selectIssuedDate.sink.add(tc.issueDate ?? '');

    response.fold(
      (_) => {_certificateLevel.add([])},
      (_) {
        if (_.certificateLevel!.isNotEmpty) {
          _certificateLevel.add(_.certificateLevel ?? []);
          for (var certificateLevel in _.certificateLevel ?? []) {
            if (certificateLevel.id == int.parse(tc.certificateLevel ?? '0')) {
              _certificateLevelListInit.sink.add(certificateLevel);
              break;
            }
          }
        }
      },
    );

    _isLoading.sink.add(false);
  }

  void selectedIssuedDate(DateTime date) {
    _issuedDate.sink.add(date);
    _selectIssuedDate.sink.add(DateFormat('yyyy-MM-dd').format(date));
  }

  void selectedCertificateLevel(val) {
    _certificateLevelListInit.sink
        .add(CommonList(id: val.value, name: val.name));
  }

  void selectedFile() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickMedia();
    if (pickedFile != null) _file.sink.add(File(pickedFile.path));
  }

  void removeFile() async => _file.sink.add(null);

  void onSubmit(BuildContext context) {
    final body = {
      "course_name": courseName.text,
      "certificate_name": certificateName.text,
      "certificate_level": _certificateLevelListInit.valueOrNull!.id ?? 0,
      "issue_date": _selectIssuedDate.valueOrNull ?? '',
      "course_duration": courseDuration.text
    };

    Logger().d("Submit: $body");

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(TrainingAndCertificationEvent(body: body, files: file));
  }

  void onUpdate(BuildContext context, TrainingCertification tc) {
    final body = {
      "training_id": tc.id,
      "course_name": courseName.text,
      "certificate_name": certificateName.text,
      "certificate_level": _certificateLevelListInit.valueOrNull!.id ?? 0,
      "issue_date": _selectIssuedDate.valueOrNull ?? '',
      "course_duration": courseDuration.text
    };

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(TrainingAndCertificationEvent(body: body, files: file));
  }

  void onDelete(BuildContext context, TrainingCertification tc) {
    final body = {"training_id": tc.id, "training_status": 'delete'};

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(TrainingAndCertificationEvent(body: body, files: file));
  }
}
