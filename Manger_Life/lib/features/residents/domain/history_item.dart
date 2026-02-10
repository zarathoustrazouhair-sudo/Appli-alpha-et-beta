import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_item.freezed.dart';

@freezed
class HistoryItem with _$HistoryItem {
  const factory HistoryItem.payment({
    required int id,
    required double amount,
    required DateTime date,
  }) = _PaymentItem;

  const factory HistoryItem.due({
    required double amount,
    required DateTime date,
    required String label, // e.g., "Cotisation Janvier 2024"
  }) = _DueItem;
}
