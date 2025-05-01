import '../models/period_model.dart';

class ScheduleModel {
  String? day;
  List<PeriodModel>? period;
  String? from;
  String? to;

  ScheduleModel({
    this.day,
    this.period,
    this.from,
    this.to,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        day: json['day'] ?? "",
        from: json['from'] ?? "",
        to: json['to'] ?? "",
        period: json["period"] != null
            ? List<PeriodModel>.from(
                json["period"].map((x) => PeriodModel.fromJson(x)))
            : json["period"],
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'from': from,
        'to': to,
        'period': period?.map((x) => x.toJson()).toList(),
      };
}
