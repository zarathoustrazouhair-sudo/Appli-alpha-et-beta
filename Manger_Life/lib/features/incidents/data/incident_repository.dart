import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/incident_model.dart';

part 'incident_repository.g.dart';

@riverpod
IncidentRepository incidentRepository(Ref ref) {
  return IncidentRepository(Supabase.instance.client);
}

class IncidentRepository {
  final SupabaseClient _supabase;

  IncidentRepository(this._supabase);

  Stream<List<IncidentModel>> watchIncidents() {
    return _supabase
        .from('incidents')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map(
          (data) => data.map((json) => IncidentModel.fromJson(json)).toList(),
        );
  }
}
