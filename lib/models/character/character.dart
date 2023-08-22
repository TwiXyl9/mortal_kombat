import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;

import 'package:syncfusion_flutter_charts/charts.dart';

import '../win_rate/win_rate.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
abstract class Character with _$Character{

  const Character._();

  const factory Character({
    String? id,
    required String name,
    required String imgUrl,
    List<WinRate>? rates,
  }) = _Character;

  factory Character.empty() => Character(name: '', imgUrl: '');

  factory Character.fromJson(Map<String,dynamic> json) => _$CharacterFromJson(json);

  factory Character.fromDocument(DocumentSnapshot doc){
    final data = doc.data()! as Map<String, dynamic>;
    return Character.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}