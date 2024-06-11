import 'package:equatable/equatable.dart';

class AppItem extends Equatable {
  const AppItem(
      {required this.avatar,
      required this.name,
      required this.description,
      required this.firstName});

  const AppItem.empty()
      : this(
          avatar: '_empty.avatar',
          name: '_empty.name',
          description: '_empty.description',
          firstName: '_empty.firstName',
        );

  final String name;
  final String firstName;
  final String avatar;
  final String description;

  @override
  List<Object?> get props => [avatar, name, firstName, description];
}
