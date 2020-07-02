import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';
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

@JsonSerializable()
class Data {
  List<Entry> entries;

  String name;
  String imageFilePath;
  bool dailyNotificationsEnabled;
  bool screenlockerEnabled;

  Data(this.entries, this.name, this.imageFilePath,
      this.dailyNotificationsEnabled, this.screenlockerEnabled);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

void setData(dynamic fn()) {
  final result = fn();
  if (result is Future) {
    result.then((_) => _writeData());
  } else {
    _writeData();
  }
}

Future<File> _getDataFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/data.json");
}

Future<Data> readData() async {
  final file = await _getDataFile();
  if (await file.exists()) {
    final result = json.decode(await file.readAsString());
    data = Data.fromJson(result);
  }
  return data;
}

void _writeData() async {
  final file = await _getDataFile();
  final result = json.encode(data.toJson());
  file.writeAsString(result);
}

void addSuccess(List<String> content) {
  setData(() {
    final now = toDate(DateTime.now());
    final entry = data.entries
        .firstWhere((element) => element.date == now, orElse: () => null);
    if (entry == null) {
      data.entries.add(Entry(now, content, [], null));
    } else {
      entry.success.addAll(content);
    }
  });
}

void addGrateful(List<String> content) {
  setData(() {
    final now = toDate(DateTime.now());
    final entry = data.entries
        .firstWhere((element) => element.date == now, orElse: () => null);
    if (entry == null) {
      data.entries.add(Entry(now, [], content, null));
    } else {
      entry.grateful.addAll(content);
    }
  });
}

void addImage(ImageEntry imageEntry){
  setData(() {
    final now = toDate(DateTime.now());
    final entry = data.entries
        .firstWhere((element) => element.date == now, orElse: () => null);
    if (entry == null) {
      data.entries.add(Entry(now, [], [], [imageEntry]));
    } else {
      entry.images.add(imageEntry);
    }
  });
}
