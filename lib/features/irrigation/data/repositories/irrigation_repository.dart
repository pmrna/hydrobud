import '../models/irrigation_preset_model.dart';

class IrrigationRepository {
  List<IrrigationPresetModel> getPresets() {
    return [
      IrrigationPresetModel(title: 'Lettuce', description: 'Description 1'),
      IrrigationPresetModel(title: 'Eggplant', description: 'Description 2'),
      IrrigationPresetModel(title: 'Bellpepper', description: 'Description 3'),
    ];
  }
}
