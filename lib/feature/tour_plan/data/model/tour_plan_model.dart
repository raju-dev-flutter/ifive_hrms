import '../../../../core/core.dart';

class TourPlanModel {
  final String? date;
  final String? day;
  final CommonList? tourTypeListInit;
  final String? tourTypeInit;
  final String? beatInit;
  final CommonList? beatListInit;
  final CommonList? tourPlanStatus;

  TourPlanModel(
      {this.date,
      this.day,
      this.tourTypeListInit,
      this.beatListInit,
      this.tourTypeInit,
      this.beatInit,
      this.tourPlanStatus});
}
