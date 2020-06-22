// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['contents'] as List)?.map((e) => e as String)?.toList(),
    _$enumDecodeNullable(_$EntryTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'contents': instance.contents,
      'type': _$EntryTypeEnumMap[instance.type],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EntryTypeEnumMap = {
  EntryType.Success: 'Success',
  EntryType.Grateful: 'Grateful',
};
