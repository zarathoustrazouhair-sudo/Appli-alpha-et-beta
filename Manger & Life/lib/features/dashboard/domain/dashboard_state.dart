import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    required double totalBalance,
    required int totalResidents,
    required int unpaidResidentsCount,
  }) = _DashboardData;
}
