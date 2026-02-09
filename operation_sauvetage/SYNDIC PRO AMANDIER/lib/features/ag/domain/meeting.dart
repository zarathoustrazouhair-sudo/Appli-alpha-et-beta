import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting.freezed.dart';
part 'meeting.g.dart';

enum MeetingStatus { scheduled, closed }

@freezed
class Meeting with _$Meeting {
  const factory Meeting({
    required int id,
    required DateTime date,
    required String location,
    required String agenda,
    required MeetingStatus status,
  }) = _Meeting;

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
}
