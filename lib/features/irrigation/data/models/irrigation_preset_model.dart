import '../../domain/entities/irrigation_preset.dart';

class IrrigationPresetModel extends IrrigationPreset {
  IrrigationPresetModel({required String title, required String description})
      : super(title: title, description: description);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
