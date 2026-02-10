import 'package:freezed_annotation/freezed_annotation.dart';

part 'incident_model.freezed.dart';
part 'incident_model.g.dart';

@freezed
class IncidentModel with _$IncidentModel {
  const IncidentModel._(); // For custom methods

  const factory IncidentModel({
    required int
    id, // Supabase ID is int8 usually, or UUID string? Dashboard insert didn't return. Let's assume int for now or String. Repository used primaryKey: ['id'].

    // Wait, drift uses Int for id. Supabase usually uses Int8 (bigint) or UUID.
    // Let's use dynamic or int. Repository map uses `IncidentModel.fromJson(json)`.
    // If Supabase `id` is big int, Dart `int` handles it (64-bit).
    required String title,
    required String description,
    @JsonKey(name: 'is_anonymous') required bool isAnonymous,
    @JsonKey(name: 'resident_phone') required String residentPhone,
    @JsonKey(name: 'apt_number') required String aptNumber,
    @JsonKey(name: 'is_urgent') @Default(false) bool isUrgent,
    @JsonKey(name: 'is_done') @Default(false) bool isDone,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'resident_name') String? residentName,
  }) = _IncidentModel;

  factory IncidentModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentModelFromJson(json);

  String get displayName {
    if (isAnonymous) {
      return "Signalement Anonyme (Apt $aptNumber)";
    } else {
      return residentName ?? "Apt $aptNumber";
    }
  }
}
