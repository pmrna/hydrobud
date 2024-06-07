import 'package:hydrobud/core/supabase_init/supabase_client.dart';
import 'package:hydrobud/features/irrigation/domain/entities/lettuce_preset.dart';
import 'package:hydrobud/features/irrigation/domain/repositories/irrigation_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintainRepositoryImpl implements IrrigationRepository {
  final SupabaseClient _supabaseClient;

  MaintainRepositoryImpl()
      : _supabaseClient = SupabaseClientInstance.supabaseClient;

  @override
  Future<void> savePreset(IrrigationPreset preset) async {
    await _supabaseClient.from('irrigation_presets').update({
      'ph_level': preset.phLevel,
      'water_concentration': preset.waterConcentration,
      'water_temperature': preset.waterTemperature,
      'liters_of_water': preset.litersOfWater,
      'isContinuing': "false",
      'crop_name': "lettuce",
      'irrig_instruction': "false"
    }).eq('id', 1);
  }
}
