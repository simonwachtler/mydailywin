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
    (json['images'] as List)
        ?.map((e) =>
            e == null ? null : ImageEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'success': instance.success,
      'grateful': instance.grateful,
      'images': instance.images,
    };

ImageEntry _$ImageEntryFromJson(Map<String, dynamic> json) {
  return ImageEntry(
    json['path'] as String,
    json['length'] as int,
  );
}

Map<String, dynamic> _$ImageEntryToJson(ImageEntry instance) =>
    <String, dynamic>{
      'path': instance.path,
      'length': instance.length,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data()
    ..entries = (json['entries'] as List)
        ?.map(
            (e) => e == null ? null : Entry.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..imageFilePath = json['imageFilePath'] as String
    ..dailyNotificationsEnabled = json['dailyNotificationsEnabled'] as bool
    ..screenlockerEnabled = json['screenlockerEnabled'] as bool
    ..notificationTime = json['notificationTime'] == null
        ? null
        : NotificationTime.fromJson(
            json['notificationTime'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'entries': instance.entries,
      'name': instance.name,
      'imageFilePath': instance.imageFilePath,
      'dailyNotificationsEnabled': instance.dailyNotificationsEnabled,
      'screenlockerEnabled': instance.screenlockerEnabled,
      'notificationTime': instance.notificationTime,
    };

NotificationTime _$NotificationTimeFromJson(Map<String, dynamic> json) {
  return NotificationTime(
    json['hour'] as int,
    json['minute'] as int,
  );
}

Map<String, dynamic> _$NotificationTimeToJson(NotificationTime instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
    };
