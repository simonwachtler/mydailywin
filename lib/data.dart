import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

import 'util.dart';

part 'data.g.dart';

@JsonSerializable()
class Entry {
  final DateTime date;
  final List<String> success;
  final List<String> grateful;
  final List<ImageEntry> images;

  Entry(this.date, this.success, this.grateful, this.images);
  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}

@JsonSerializable()
class ImageEntry {
  final String path;
  int length;

  ImageEntry(this.path, this.length);
  factory ImageEntry.fromJson(Map<String, dynamic> json) =>
      _$ImageEntryFromJson(json);
  Map<String, dynamic> toJson() => _$ImageEntryToJson(this);
}

class DataModel extends ChangeNotifier {
  Data _data = Data();
  bool loading = true;

  UnmodifiableListView get entries => UnmodifiableListView(_data.entries);
  String get name => _data.name;
  String get imageFilePath => _data.imageFilePath;
  bool get dailyNotificationsEnabled => _data.dailyNotificationsEnabled;
  bool get screenlockerEnabled => _data.screenlockerEnabled;
  NotificationTime get notificationTime => _data.notificationTime;

  void load() async {
    // Backwards compatibility
    _data = (await readData())..notificationTime ??= _data.notificationTime;
    loading = false;
    notifyListeners();
  }

  void _dataChanged() {
    notifyListeners();
    _writeData();
  }

  void _writeData() async {
    final file = await _getDataFile();
    final result = json.encode(_data.toJson());
    file.writeAsString(result);
  }

  void addSuccess(List<String> content) {
    final now = toDate(DateTime.now());
    final entry = _data.entries
        .firstWhere((element) => element.date == now, orElse: () => null);
    if (entry == null) {
      _data.entries.add(Entry(now, content, [], null));
    } else {
      entry.success.addAll(content);
    }
    _dataChanged();
  }

  void addGrateful(List<String> content) {
    final now = toDate(DateTime.now());
    final entry = _data.entries
        .firstWhere((element) => element.date == now, orElse: () => null);
    if (entry == null) {
      _data.entries.add(Entry(now, [], content, null));
    } else {
      entry.grateful.addAll(content);
    }
    _dataChanged();
  }

  void addImage(ImageEntry imageEntry) {
    final now = toDate(DateTime.now());
    final entry = _data.entries
        .firstWhere((element) => element.date == now, orElse: () => null);
    if (entry == null) {
      _data.entries.add(Entry(now, [], [], [imageEntry]));
    } else {
      entry.images.add(imageEntry);
    }
    _dataChanged();
  }

  void removeEntry(int index) {
    final entry = _data.entries.removeAt(index);
    entry.images?.forEach((image) {
      File(image.path).delete();
    });
    _dataChanged();
  }

  void replaceEntry(int index, Entry newEntry) {
    final oldEntry = _data.entries[index];
    _data.entries[index] = newEntry;
    oldEntry.images?.forEach((image) {
      if (!newEntry.images.any((i) => i.path == image.path)) {
        File(image.path).delete();
      }
    });
    _dataChanged();
  }

  set name(String name) {
    _data.name = name;
    notifyListeners();
  }

  set imageFilePath(String imageFilePath) {
    _data.imageFilePath = imageFilePath;
    _dataChanged();
  }

  set dailyNotificationsEnabled(bool dailyNotificationsEnabled) {
    _data.dailyNotificationsEnabled = dailyNotificationsEnabled;
    _dataChanged();
  }

  setNotificationTime(TimeOfDay time) {
    _data.notificationTime = NotificationTime(time.hour, time.minute);
    _dataChanged();
  }

  set screenlockerEnabled(bool screenlockerEnabled) {
    _data.screenlockerEnabled = screenlockerEnabled;
    _dataChanged();
  }
}

@JsonSerializable()
class Data {
  List<Entry> entries = [];
  String name;
  String imageFilePath;
  bool dailyNotificationsEnabled = true;
  bool screenlockerEnabled = false;
  NotificationTime notificationTime = NotificationTime(8, 0);

  Data();

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class NotificationTime {
  final int hour, minute;

  const NotificationTime(this.hour, this.minute);

  factory NotificationTime.fromJson(Map<String, dynamic> json) =>
      _$NotificationTimeFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationTimeToJson(this);

  Time toTime() {
    return Time(hour, minute);
  }

  DateTime toDateTime() {
    return DateTime(1970, 1, 1, hour, minute);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }
}

Future<File> _getDataFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/data.json");
}

Future<Data> readData() async {
  final file = await _getDataFile();
  Data data;
  if (await file.exists()) {
    final result = json.decode(await file.readAsString());
    data = Data.fromJson(result);
  }
  return data ?? Data();
}
