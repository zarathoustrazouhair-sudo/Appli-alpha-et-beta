// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resident_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$residentHistoryHash() => r'd69b8494d7de34bd4d8bc14c4dfbf730c73a77a4';

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

abstract class _$ResidentHistory
    extends BuildlessAutoDisposeStreamNotifier<List<HistoryItem>> {
  late final Resident resident;

  Stream<List<HistoryItem>> build(
    Resident resident,
  );
}

/// See also [ResidentHistory].
@ProviderFor(ResidentHistory)
const residentHistoryProvider = ResidentHistoryFamily();

/// See also [ResidentHistory].
class ResidentHistoryFamily extends Family<AsyncValue<List<HistoryItem>>> {
  /// See also [ResidentHistory].
  const ResidentHistoryFamily();

  /// See also [ResidentHistory].
  ResidentHistoryProvider call(
    Resident resident,
  ) {
    return ResidentHistoryProvider(
      resident,
    );
  }

  @override
  ResidentHistoryProvider getProviderOverride(
    covariant ResidentHistoryProvider provider,
  ) {
    return call(
      provider.resident,
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
  String? get name => r'residentHistoryProvider';
}

/// See also [ResidentHistory].
class ResidentHistoryProvider extends AutoDisposeStreamNotifierProviderImpl<
    ResidentHistory, List<HistoryItem>> {
  /// See also [ResidentHistory].
  ResidentHistoryProvider(
    Resident resident,
  ) : this._internal(
          () => ResidentHistory()..resident = resident,
          from: residentHistoryProvider,
          name: r'residentHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$residentHistoryHash,
          dependencies: ResidentHistoryFamily._dependencies,
          allTransitiveDependencies:
              ResidentHistoryFamily._allTransitiveDependencies,
          resident: resident,
        );

  ResidentHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.resident,
  }) : super.internal();

  final Resident resident;

  @override
  Stream<List<HistoryItem>> runNotifierBuild(
    covariant ResidentHistory notifier,
  ) {
    return notifier.build(
      resident,
    );
  }

  @override
  Override overrideWith(ResidentHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: ResidentHistoryProvider._internal(
        () => create()..resident = resident,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        resident: resident,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<ResidentHistory, List<HistoryItem>>
      createElement() {
    return _ResidentHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResidentHistoryProvider && other.resident == resident;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, resident.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ResidentHistoryRef
    on AutoDisposeStreamNotifierProviderRef<List<HistoryItem>> {
  /// The parameter `resident` of this provider.
  Resident get resident;
}

class _ResidentHistoryProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ResidentHistory,
        List<HistoryItem>> with ResidentHistoryRef {
  _ResidentHistoryProviderElement(super.provider);

  @override
  Resident get resident => (origin as ResidentHistoryProvider).resident;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
