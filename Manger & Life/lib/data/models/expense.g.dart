// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String? ?? 'Autre',
      proofImagePath: json['proofImagePath'] as String,
      date: DateTime.parse(json['date'] as String),
      providerName: json['providerName'] as String?,
      providerId: (json['providerId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'category': instance.category,
      'proofImagePath': instance.proofImagePath,
      'date': instance.date.toIso8601String(),
      'providerName': instance.providerName,
      'providerId': instance.providerId,
    };
