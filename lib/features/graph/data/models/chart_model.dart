import 'package:hydrobud/features/graph/domain/entities/chart.dart';

class ChartDataModel extends Chart {
  ChartDataModel({
    required super.label,
    required super.value,
    required super.time,
  });

  // Map<String, dynamic> toJson() {
  //   return <String, dynamic>{
  //     'label': label,
  //     'value': value,
  //     'time': time,
  //   };
  // }

  factory ChartDataModel.fromJson(Map<String, dynamic> map) {
    return ChartDataModel(
      label: map['sensor_name'] as String,
      value:
          (map['value'] != null) ? double.parse(map['value'].toString()) : 0.0,
      time: map['time'] != null
          ? DateTime.parse(map['time'])
          : DateTime.now(), // Default to current time if null
    );
  }

  ChartDataModel copyWith({
    String? label,
    double? value,
    DateTime? time,
  }) {
    return ChartDataModel(
      label: label ?? this.label,
      value: value ?? this.value,
      time: time ?? this.time,
    );
  }
}
