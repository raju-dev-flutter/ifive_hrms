part of 'account_crud_bloc.dart';

abstract class AccountCrudEvent extends Equatable {
  const AccountCrudEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUploadEvent extends AccountCrudEvent {
  final DataMap body;

  const ProfileUploadEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class ProfileEditEvent extends AccountCrudEvent {
  final DataMap body;

  const ProfileEditEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class SkillInsertEvent extends AccountCrudEvent {
  final DataMap body;
  final File? file;

  const SkillInsertEvent({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}

class SkillUpdateEvent extends AccountCrudEvent {
  final DataMap body;
  final File? file;

  const SkillUpdateEvent({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}

class ExperienceEvent extends AccountCrudEvent {
  final DataMap body;
  final File? file;

  const ExperienceEvent({required this.body, required this.file});

  @override
  List<Object?> get props => [body, file];
}

class EducationEvent extends AccountCrudEvent {
  final DataMap body;
  final File? files;

  const EducationEvent({required this.body, required this.files});

  @override
  List<Object?> get props => [body, files];
}

class ContactEvent extends AccountCrudEvent {
  final DataMap body;

  const ContactEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class PersonalEvent extends AccountCrudEvent {
  final DataMap body;

  const PersonalEvent({required this.body});

  @override
  List<Object> get props => [body];
}

class TrainingAndCertificationEvent extends AccountCrudEvent {
  final DataMap body;
  final File? files;

  const TrainingAndCertificationEvent(
      {required this.body, required this.files});

  @override
  List<Object?> get props => [body, files];
}

class VisaAndImmigrationEvent extends AccountCrudEvent {
  final DataMap body;
  final File? files;

  const VisaAndImmigrationEvent({required this.body, required this.files});

  @override
  List<Object?> get props => [body, files];
}
