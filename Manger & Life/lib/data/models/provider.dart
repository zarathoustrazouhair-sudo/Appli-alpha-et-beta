import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';

@freezed
class Provider with _$Provider {
  const factory Provider({
    required int id,
    required String name,
    required String jobType,
    required String phone,
  }) = _Provider;

  factory Provider.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);
}
