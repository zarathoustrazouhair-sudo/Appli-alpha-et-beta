import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/utils/formatters.dart';
import '../../../../domain/repositories/resident_repository.dart';

part 'sync_service.g.dart';

@riverpod
SyncService syncService(Ref ref) {
  final residentRepo = ref.watch(residentRepositoryProvider);
  return SyncService(Supabase.instance.client, residentRepo);
}

class SyncService {
  final SupabaseClient _supabase;
  final ResidentRepository _residentRepo;

  SyncService(this._supabase, this._residentRepo);

  Future<void> uploadResidentStatus() async {
    // 1. Get all local residents
    final residents = await _residentRepo.getResidents();

    // 2. Iterate and upsert
    for (var resident in residents) {
      if (resident.phone.isEmpty) continue;

      // Calculate balance
      final balance = await _residentRepo.getResidentBalance(resident).first;

      // Clean phone number for consistency
      final number = Formatters.formatWhatsAppNumber(resident.phone);

      // Upsert to Supabase
      // Table: resident_status (phone (PK), balance, last_updated, apt_number, floor_number, pin_code, resident_name)
      await _supabase.from('resident_status').upsert({
        'phone': number,
        'balance': balance,
        'last_updated': DateTime.now().toIso8601String(),
        'resident_name': resident.name,
        'apt_number': resident.apartment,
        'floor_number': resident.floor ?? 0,
        'pin_code': resident.pinCode, // CRITICAL FIX: Sync PIN
      });
    }
  }
}
