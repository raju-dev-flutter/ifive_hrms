import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifive_hrms/feature/account/account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';

class ProfileSkillsStream {
  ProfileSkillsStream({required CompetencyLevelUseCase competencyLevelUseCase})
      : _competencyLevelUseCase = competencyLevelUseCase;

  final CompetencyLevelUseCase _competencyLevelUseCase;

  final _isLoading = BehaviorSubject<bool>.seeded(false);

  late TextEditingController skill = TextEditingController();
  late TextEditingController version = TextEditingController();

  final _competencyLevel = BehaviorSubject<List<CommonList>>.seeded([]);
  final _competencyLevelListInit = BehaviorSubject<CommonList>();

  final _file = BehaviorSubject<File?>();

  ValueStream<bool> get isLoading => _isLoading.stream;

  Stream<List<CommonList>> get competencyLevel => _competencyLevel.stream;

  ValueStream<CommonList> get competencyLevelListInit =>
      _competencyLevelListInit.stream;

  ValueStream<File?> get file => _file.stream;

  Future<void> fetchInitialCallBack() async {
    final response = await _competencyLevelUseCase();
    response.fold(
      (_) => {_competencyLevel.add([])},
      (_) {
        if (_.competencyLevel!.isNotEmpty) {
          _competencyLevel.add(_.competencyLevel ?? []);
        }
      },
    );
  }

  void fetchInitialCallBackWithDetail(Skills? skills) async {
    _isLoading.sink.add(true);
    final response = await _competencyLevelUseCase();
    skill = TextEditingController(text: skills!.skill ?? '');
    version = TextEditingController(text: skills.version ?? '');

    response.fold(
      (_) => {_competencyLevel.add([])},
      (_) {
        if (_.competencyLevel!.isNotEmpty) {
          _competencyLevel.add(_.competencyLevel ?? []);
          for (var competencyLevel in _.competencyLevel!) {
            if (competencyLevel.id ==
                int.parse(skills.competencyLevel ?? '0')) {
              _competencyLevelListInit.sink.add(competencyLevel);
              break;
            }
          }
        }
      },
    );

    _isLoading.sink.add(false);
  }

  void selectedCompetencyLevel(val) {
    _competencyLevelListInit.sink
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
      "skill": skill.text,
      "version": version.text,
      "competency_level": _competencyLevelListInit.valueOrNull!.id ?? 0,
    };

    Logger().d("Submit: $body");

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(SkillInsertEvent(body: body, file: file));
  }

  void onUpdate(BuildContext context, Skills skills) {
    final body = {
      "skill_id": skills.id,
      "skill": skill.text,
      "version": version.text,
      "competency_level": _competencyLevelListInit.valueOrNull!.id ?? 0,
    };

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(SkillInsertEvent(body: body, file: file));
  }

  void onDelete(BuildContext context, Skills skills) {
    final body = {"skill_id": skills.id, "skill_status": 'delete'};

    final file = _file.valueOrNull;
    BlocProvider.of<AccountCrudBloc>(context)
        .add(SkillInsertEvent(body: body, file: file));
  }

  void onClose() {
    skill.clear();
    version.clear();
    _competencyLevelListInit.add(CommonList());
    _file.add(null);
  }
}
