import 'package:equatable/equatable.dart';

class DashboardItem extends Equatable {
  final String icon;
  final String label;

  const DashboardItem({required this.icon, required this.label});

  const DashboardItem.empty()
      : this(icon: '_empty.icon', label: '_empty.label');

  @override
  List<Object?> get props => [icon, label];
}
