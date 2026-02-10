import 'package:freezed_annotation/freezed_annotation.dart';

part 'resident.freezed.dart';
part 'resident.g.dart';

@freezed
class Resident with _$Resident {
  const factory Resident({
    required int id,
    required String name,
    required String phone,
    required String building,
    required String apartment,
    int? floor,
    @Default(250) int monthlyFee,
    required DateTime startDate,
    String? pinCode, // ADDED
  }) = _Resident;

  factory Resident.fromJson(Map<String, dynamic> json) =>
      _$ResidentFromJson(json);
}
