// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$meetingsListHash() => r'd0be3f60e477d871387142d5f12e652adbe8383f';

/// See also [MeetingsList].
@ProviderFor(MeetingsList)
final meetingsListProvider =
    AutoDisposeAsyncNotifierProvider<MeetingsList, List<Meeting>>.internal(
  MeetingsList.new,
  name: r'meetingsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$meetingsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MeetingsList = AutoDisposeAsyncNotifier<List<Meeting>>;
String _$meetingAttendanceStateHash() =>
    r'81f6a1c43d27a293abe307c00f9c468bdeebbc3d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MeetingAttendanceState
    extends BuildlessAutoDisposeAsyncNotifier<Map<int, bool>> {
  late final int meetingId;

  FutureOr<Map<int, bool>> build(
    int meetingId,
  );
}

/// See also [MeetingAttendanceState].
@ProviderFor(MeetingAttendanceState)
const meetingAttendanceStateProvider = MeetingAttendanceStateFamily();

/// See also [MeetingAttendanceState].
class MeetingAttendanceStateFamily extends Family<AsyncValue<Map<int, bool>>> {
  /// See also [MeetingAttendanceState].
  const MeetingAttendanceStateFamily();

  /// See also [MeetingAttendanceState].
  MeetingAttendanceStateProvider call(
    int meetingId,
  ) {
    return MeetingAttendanceStateProvider(
      meetingId,
    );
  }

  @override
  MeetingAttendanceStateProvider getProviderOverride(
    covariant MeetingAttendanceStateProvider provider,
  ) {
    return call(
      provider.meetingId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'meetingAttendanceStateProvider';
}

/// See also [MeetingAttendanceState].
class MeetingAttendanceStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MeetingAttendanceState,
        Map<int, bool>> {
  /// See also [MeetingAttendanceState].
  MeetingAttendanceStateProvider(
    int meetingId,
  ) : this._internal(
          () => MeetingAttendanceState()..meetingId = meetingId,
          from: meetingAttendanceStateProvider,
          name: r'meetingAttendanceStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$meetingAttendanceStateHash,
          dependencies: MeetingAttendanceStateFamily._dependencies,
          allTransitiveDependencies:
              MeetingAttendanceStateFamily._allTransitiveDependencies,
          meetingId: meetingId,
        );

  MeetingAttendanceStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.meetingId,
  }) : super.internal();

  final int meetingId;

  @override
  FutureOr<Map<int, bool>> runNotifierBuild(
    covariant MeetingAttendanceState notifier,
  ) {
    return notifier.build(
      meetingId,
    );
  }

  @override
  Override overrideWith(MeetingAttendanceState Function() create) {
    return ProviderOverride(
      origin: this,
      override: MeetingAttendanceStateProvider._internal(
        () => create()..meetingId = meetingId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        meetingId: meetingId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MeetingAttendanceState,
      Map<int, bool>> createElement() {
    return _MeetingAttendanceStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MeetingAttendanceStateProvider &&
        other.meetingId == meetingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, meetingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MeetingAttendanceStateRef
    on AutoDisposeAsyncNotifierProviderRef<Map<int, bool>> {
  /// The parameter `meetingId` of this provider.
  int get meetingId;
}

class _MeetingAttendanceStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MeetingAttendanceState,
        Map<int, bool>> with MeetingAttendanceStateRef {
  _MeetingAttendanceStateProviderElement(super.provider);

  @override
  int get meetingId => (origin as MeetingAttendanceStateProvider).meetingId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
