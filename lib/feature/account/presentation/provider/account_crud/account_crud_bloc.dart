import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../account.dart';

part 'account_crud_event.dart';
part 'account_crud_state.dart';

class AccountCrudBloc extends Bloc<AccountCrudEvent, AccountCrudState> {
  AccountCrudBloc(
      {required ProfileUpload profileUpload,
      required ProfileEdit profileEdit,
      required SkillUpdateUseCase $SkillUpdateUseCase,
      required SkillInsertUseCase $SkillInsertUseCase,
      required ExperienceUseCase $ExperienceUseCase,
      required EducationUseCase $EducationUseCase,
      required ContactUseCase $ContactUseCase,
      required PersonalSaveUseCase $PersonalSaveUseCase,
      required TrainingCertificationUseCase $TrainingCertificationUseCase,
      required VisaImmigrationUseCase $VisaImmigrationUseCase})
      : _profileUpload = profileUpload,
        _profileEdit = profileEdit,
        _$SkillInsertUseCase = $SkillInsertUseCase,
        _$SkillUpdateUseCase = $SkillUpdateUseCase,
        _$ExperienceUseCase = $ExperienceUseCase,
        _$EducationUseCase = $EducationUseCase,
        _$ContactUseCase = $ContactUseCase,
        _$PersonalSaveUseCase = $PersonalSaveUseCase,
        _$TrainingCertificationUseCase = $TrainingCertificationUseCase,
        _$VisaImmigrationUseCase = $VisaImmigrationUseCase,
        super(initialState()) {
    on<ProfileUploadEvent>(_profileUploadEvent);
    on<ProfileEditEvent>(_profileEditEvent);
    on<SkillInsertEvent>(_skillInsertEvent);
    on<SkillUpdateEvent>(_skillUpdateEvent);
    on<ExperienceEvent>(_experienceEvent);
    on<EducationEvent>(_educationEvent);
    on<ContactEvent>(_contactEvent);
    on<PersonalEvent>(_personalEvent);
    on<TrainingAndCertificationEvent>(_trainingAndCertificationEvent);
    on<VisaAndImmigrationEvent>(_visaAndImmigrationEvent);
  }

  static initialState() => const AccountCrudInitial();

  final ProfileUpload _profileUpload;
  final ProfileEdit _profileEdit;
  final SkillInsertUseCase _$SkillInsertUseCase;
  final SkillUpdateUseCase _$SkillUpdateUseCase;
  final ExperienceUseCase _$ExperienceUseCase;
  final EducationUseCase _$EducationUseCase;
  final ContactUseCase _$ContactUseCase;
  final PersonalSaveUseCase _$PersonalSaveUseCase;
  final TrainingCertificationUseCase _$TrainingCertificationUseCase;
  final VisaImmigrationUseCase _$VisaImmigrationUseCase;

  void _profileUploadEvent(
      ProfileUploadEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response =
        await _profileUpload(UploadRequestParams(body: event.body));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _profileEditEvent(
      ProfileEditEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _profileEdit(EditRequestParams(body: event.body));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _skillInsertEvent(
      SkillInsertEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _$SkillInsertUseCase(
        SkillInsertParams(body: event.body, file: event.file));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _skillUpdateEvent(
      SkillUpdateEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _$SkillUpdateUseCase(
        SkillUpdateParams(body: event.body, file: event.file));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _experienceEvent(
      ExperienceEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _$ExperienceUseCase(
        ExperienceParams(body: event.body, file: event.file));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _educationEvent(
      EducationEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _$EducationUseCase(
        EducationParams(body: event.body, file: event.files));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _contactEvent(ContactEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _$ContactUseCase(ContactParams(body: event.body));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _personalEvent(
      PersonalEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response =
        await _$PersonalSaveUseCase(PersonalParams(body: event.body));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _trainingAndCertificationEvent(TrainingAndCertificationEvent event,
      Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _$TrainingCertificationUseCase(
        TrainingCertificationParams(body: event.body, file: event.files));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }

  void _visaAndImmigrationEvent(
      VisaAndImmigrationEvent event, Emitter<AccountCrudState> emit) async {
    emit(const AccountCrudLoading());
    final response = await _$VisaImmigrationUseCase(
        VisaImmigrationParams(body: event.body, file: event.files));
    response.fold(
      (_) => emit(AccountCrudFailed(message: _.message)),
      (__) => emit(const AccountCrudSuccess()),
    );
  }
}
