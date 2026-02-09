// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residents_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$residentBalanceHash() => r'114ffaba52b43efd6526c6a98c0210cd8a4c56fc';

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

/// See also [residentBalance].
@ProviderFor(residentBalance)
const residentBalanceProvider = ResidentBalanceFamily();

/// See also [residentBalance].
class ResidentBalanceFamily extends Family<AsyncValue<double>> {
  /// See also [residentBalance].
  const ResidentBalanceFamily();

  /// See also [residentBalance].
  ResidentBalanceProvider call(
    Resident resident,
  ) {
    return ResidentBalanceProvider(
      resident,
    );
  }

  @override
  ResidentBalanceProvider getProviderOverride(
    covariant ResidentBalanceProvider provider,
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
  String? get name => r'residentBalanceProvider';
}

/// See also [residentBalance].
class ResidentBalanceProvider extends AutoDisposeStreamProvider<double> {
  /// See also [residentBalance].
  ResidentBalanceProvider(
    Resident resident,
  ) : this._internal(
          (ref) => residentBalance(
            ref as ResidentBalanceRef,
            resident,
          ),
          from: residentBalanceProvider,
          name: r'residentBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$residentBalanceHash,
          dependencies: ResidentBalanceFamily._dependencies,
          allTransitiveDependencies:
              ResidentBalanceFamily._allTransitiveDependencies,
          resident: resident,
        );

  ResidentBalanceProvider._internal(
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
  Override overrideWith(
    Stream<double> Function(ResidentBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ResidentBalanceProvider._internal(
        (ref) => create(ref as ResidentBalanceRef),
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
  AutoDisposeStreamProviderElement<double> createElement() {
    return _ResidentBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResidentBalanceProvider && other.resident == resident;
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
mixin ResidentBalanceRef on AutoDisposeStreamProviderRef<double> {
  /// The parameter `resident` of this provider.
  Resident get resident;
}

class _ResidentBalanceProviderElement
    extends AutoDisposeStreamProviderElement<double> with ResidentBalanceRef {
  _ResidentBalanceProviderElement(super.provider);

  @override
  Resident get resident => (origin as ResidentBalanceProvider).resident;
}

String _$residentsListHash() => r'c4d3d9c420384c66ee8fab310c29fbd2d26347ca';

/// See also [ResidentsList].
@ProviderFor(ResidentsList)
final residentsListProvider =
    AutoDisposeStreamNotifierProvider<ResidentsList, List<Resident>>.internal(
  ResidentsList.new,
  name: r'residentsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$residentsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ResidentsList = AutoDisposeStreamNotifier<List<Resident>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
