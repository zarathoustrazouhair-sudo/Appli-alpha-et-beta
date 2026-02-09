// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apartmentsStreamHash() => r'47a771957517da7ea45a4cae98ffcbd45603f6db';

/// See also [apartmentsStream].
@ProviderFor(apartmentsStream)
final apartmentsStreamProvider =
    AutoDisposeStreamProvider<List<Apartment>>.internal(
  apartmentsStream,
  name: r'apartmentsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apartmentsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApartmentsStreamRef = AutoDisposeStreamProviderRef<List<Apartment>>;
String _$apartmentBalanceHash() => r'ab7e61dbcbabd56fca2b2d1502aa282f9bc070ef';

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

/// See also [apartmentBalance].
@ProviderFor(apartmentBalance)
const apartmentBalanceProvider = ApartmentBalanceFamily();

/// See also [apartmentBalance].
class ApartmentBalanceFamily extends Family<AsyncValue<double>> {
  /// See also [apartmentBalance].
  const ApartmentBalanceFamily();

  /// See also [apartmentBalance].
  ApartmentBalanceProvider call(
    int apartmentId,
  ) {
    return ApartmentBalanceProvider(
      apartmentId,
    );
  }

  @override
  ApartmentBalanceProvider getProviderOverride(
    covariant ApartmentBalanceProvider provider,
  ) {
    return call(
      provider.apartmentId,
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
  String? get name => r'apartmentBalanceProvider';
}

/// See also [apartmentBalance].
class ApartmentBalanceProvider extends AutoDisposeStreamProvider<double> {
  /// See also [apartmentBalance].
  ApartmentBalanceProvider(
    int apartmentId,
  ) : this._internal(
          (ref) => apartmentBalance(
            ref as ApartmentBalanceRef,
            apartmentId,
          ),
          from: apartmentBalanceProvider,
          name: r'apartmentBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$apartmentBalanceHash,
          dependencies: ApartmentBalanceFamily._dependencies,
          allTransitiveDependencies:
              ApartmentBalanceFamily._allTransitiveDependencies,
          apartmentId: apartmentId,
        );

  ApartmentBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.apartmentId,
  }) : super.internal();

  final int apartmentId;

  @override
  Override overrideWith(
    Stream<double> Function(ApartmentBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApartmentBalanceProvider._internal(
        (ref) => create(ref as ApartmentBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        apartmentId: apartmentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<double> createElement() {
    return _ApartmentBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApartmentBalanceProvider &&
        other.apartmentId == apartmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, apartmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ApartmentBalanceRef on AutoDisposeStreamProviderRef<double> {
  /// The parameter `apartmentId` of this provider.
  int get apartmentId;
}

class _ApartmentBalanceProviderElement
    extends AutoDisposeStreamProviderElement<double> with ApartmentBalanceRef {
  _ApartmentBalanceProviderElement(super.provider);

  @override
  int get apartmentId => (origin as ApartmentBalanceProvider).apartmentId;
}

String _$financialRepositoryHash() =>
    r'00df59e5cc5e673c26d2d69c40982d6c073bef48';

/// See also [financialRepository].
@ProviderFor(financialRepository)
final financialRepositoryProvider = Provider<FinancialRepository>.internal(
  financialRepository,
  name: r'financialRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$financialRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FinancialRepositoryRef = ProviderRef<FinancialRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
