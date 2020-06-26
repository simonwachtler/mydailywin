import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';

part 'data.g.dart';

enum EntryType { Success, Grateful }

@JsonSerializable()
class Entry {
  final DateTime date;
  final List<String> contents;
  final EntryType type;

  Entry(this.date, this.contents, this.type);
  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
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

void setData(VoidCallback fn) {
  fn();
  writeData();
}

Future<File> getDataFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/data.json");
}

Future<void> readData() async {
  final file = await getDataFile();
  if (await file.exists()) {
    final result = json.decode(await file.readAsString());
    data = Data.fromJson(result);
  }
  data.entries ??= [];
}

void writeData() async {
  final file = await getDataFile();
  final result = json.encode(data.toJson());
  file.writeAsString(result);
}
