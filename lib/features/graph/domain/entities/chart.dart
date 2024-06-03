class Chart {
  final String label;
  final double value;
  final DateTime time;

  Chart({
    required this.label,
    required this.value,
    required this.time,
  });

  factory Chart.fromMap(Map<String, dynamic> map) {
    return Chart(
      label: map['sensor_name'] as String,
      value: double.parse(map['value'].toString()),
      time: DateTime.parse(map['time']),
    );
  }
}
