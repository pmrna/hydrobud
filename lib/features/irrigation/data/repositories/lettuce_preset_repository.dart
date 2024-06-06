import 'package:hydrobud/features/irrigation/domain/entities/irrigation_preset.dart';

abstract class IrrigationRepository {
  Future<void> savePreset(IrrigationPreset preset);
}
