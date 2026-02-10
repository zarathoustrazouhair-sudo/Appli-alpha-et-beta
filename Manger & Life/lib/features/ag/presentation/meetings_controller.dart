import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/meeting.dart';
import '../domain/meeting_repository.dart';

part 'meetings_controller.g.dart';

@riverpod
class MeetingsList extends _$MeetingsList {
  @override
  FutureOr<List<Meeting>> build() async {
    final repository = ref.watch(meetingRepositoryProvider);
    return repository.getMeetings();
  }

  Future<void> createMeeting(
    DateTime date,
    String location,
    String agenda,
  ) async {
    final repository = ref.read(meetingRepositoryProvider);
    await repository.createMeeting(date, location, agenda);
    ref.invalidateSelf();
  }

  Future<void> closeMeeting(int meetingId) async {
    final repository = ref.read(meetingRepositoryProvider);
    await repository.closeMeeting(meetingId);
    ref.invalidateSelf();
  }
}

@riverpod
class MeetingAttendanceState extends _$MeetingAttendanceState {
  @override
  FutureOr<Map<int, bool>> build(int meetingId) async {
    final repository = ref.watch(meetingRepositoryProvider);
    return repository.getAttendance(meetingId);
  }

  Future<void> toggleAttendance(int residentId, bool isPresent) async {
    final repository = ref.read(meetingRepositoryProvider);
    await repository.markAttendance(meetingId, residentId, isPresent);
    ref.invalidateSelf();
  }
}
