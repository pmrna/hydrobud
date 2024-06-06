import 'package:hydrobud/features/irrigation/domain/entities/lettuce_preset.dart';

abstract class IrrigationRepository {
  Future<void> savePreset(IrrigationPreset preset);
}
