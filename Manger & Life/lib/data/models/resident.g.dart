// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResidentImpl _$$ResidentImplFromJson(Map<String, dynamic> json) =>
    _$ResidentImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      building: json['building'] as String,
      apartment: json['apartment'] as String,
      floor: (json['floor'] as num?)?.toInt(),
      monthlyFee: (json['monthlyFee'] as num?)?.toInt() ?? 250,
      startDate: DateTime.parse(json['startDate'] as String),
      pinCode: json['pinCode'] as String?,
    );

Map<String, dynamic> _$$ResidentImplToJson(_$ResidentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'building': instance.building,
      'apartment': instance.apartment,
      'floor': instance.floor,
      'monthlyFee': instance.monthlyFee,
      'startDate': instance.startDate.toIso8601String(),
      'pinCode': instance.pinCode,
    };
