import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'win_rate.freezed.dart';
part 'win_rate.g.dart';

@freezed
abstract class WinRate with _$WinRate{

  const WinRate._();

  const factory WinRate({
    String? id,
    required int value,
  }) = _WinRate;

  factory WinRate.empty() => WinRate(value: 0);

  factory WinRate.fromJson(Map<String,dynamic> json) => _$WinRateFromJson(json);

  factory WinRate.fromDocument(DocumentSnapshot doc){
    final data = doc.data()! as Map<String, dynamic>;
    return WinRate.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}