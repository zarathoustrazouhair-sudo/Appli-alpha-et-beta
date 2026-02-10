// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetingImpl _$$MeetingImplFromJson(Map<String, dynamic> json) =>
    _$MeetingImpl(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      agenda: json['agenda'] as String,
      status: $enumDecode(_$MeetingStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$MeetingImplToJson(_$MeetingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'location': instance.location,
      'agenda': instance.agenda,
      'status': _$MeetingStatusEnumMap[instance.status]!,
    };

const _$MeetingStatusEnumMap = {
  MeetingStatus.scheduled: 'scheduled',
  MeetingStatus.closed: 'closed',
};
