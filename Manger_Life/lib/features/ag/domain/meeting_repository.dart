import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' as drift;
import '../../../data/database/database.dart';
import '../../../data/database/database_provider.dart';
import 'meeting.dart' as entity;

part 'meeting_repository.g.dart';

@riverpod
MeetingRepository meetingRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return MeetingRepository(db);
}

class MeetingRepository {
  final AppDatabase _db;
  MeetingRepository(this._db);

  Future<List<entity.Meeting>> getMeetings() async {
    final rows =
        await (_db.select(_db.meetings)..orderBy([
              (t) => drift.OrderingTerm(
                expression: t.date,
                mode: drift.OrderingMode.desc,
              ),
            ]))
            .get();
    return rows
        .map(
          (m) => entity.Meeting(
            id: m.id,
            date: m.date,
            location: m.location,
            agenda: m.agenda,
            status: m.status == 1
                ? entity.MeetingStatus.closed
                : entity.MeetingStatus.scheduled,
          ),
        )
        .toList();
  }

  Future<int> createMeeting(DateTime date, String location, String agenda) {
    return _db
        .into(_db.meetings)
        .insert(
          MeetingsCompanion(
            date: drift.Value(date),
            location: drift.Value(location),
            agenda: drift.Value(agenda),
            status: const drift.Value(0),
          ),
        );
  }

  Future<void> closeMeeting(int meetingId) {
    return (_db.update(_db.meetings)..where((t) => t.id.equals(meetingId)))
        .write(const MeetingsCompanion(status: drift.Value(1)));
  }

  Future<void> markAttendance(int meetingId, int residentId, bool isPresent) {
    return _db
        .into(_db.meetingAttendance)
        .insertOnConflictUpdate(
          MeetingAttendanceCompanion(
            meetingId: drift.Value(meetingId),
            residentId: drift.Value(residentId),
            isPresent: drift.Value(isPresent),
          ),
        );
  }

  Future<Map<int, bool>> getAttendance(int meetingId) async {
    final rows = await (_db.select(
      _db.meetingAttendance,
    )..where((t) => t.meetingId.equals(meetingId))).get();
    return {for (var r in rows) r.residentId: r.isPresent};
  }
}
