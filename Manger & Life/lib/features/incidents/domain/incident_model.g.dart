// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncidentModelImpl _$$IncidentModelImplFromJson(Map<String, dynamic> json) =>
    _$IncidentModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      isAnonymous: json['is_anonymous'] as bool,
      residentPhone: json['resident_phone'] as String,
      aptNumber: json['apt_number'] as String,
      isUrgent: json['is_urgent'] as bool? ?? false,
      isDone: json['is_done'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      residentName: json['resident_name'] as String?,
    );

Map<String, dynamic> _$$IncidentModelImplToJson(_$IncidentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_anonymous': instance.isAnonymous,
      'resident_phone': instance.residentPhone,
      'apt_number': instance.aptNumber,
      'is_urgent': instance.isUrgent,
      'is_done': instance.isDone,
      'created_at': instance.createdAt.toIso8601String(),
      'resident_name': instance.residentName,
    };
