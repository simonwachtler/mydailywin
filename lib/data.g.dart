// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['success'] as List)?.map((e) => e as String)?.toList(),
    (json['grateful'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'success': instance.success,
      'grateful': instance.grateful,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['entries'] as List)
        ?.map(
            (e) => e == null ? null : Entry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['name'] as String,
    json['imageFilePath'] as String,
    json['dailyNotificationsEnabled'] as bool,
    json['screenlockerEnabled'] as bool,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'entries': instance.entries,
      'name': instance.name,
      'imageFilePath': instance.imageFilePath,
      'dailyNotificationsEnabled': instance.dailyNotificationsEnabled,
      'screenlockerEnabled': instance.screenlockerEnabled,
    };
