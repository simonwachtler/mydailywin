import 'dart:convert';
import 'dart:io';

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

Future<File> getDataFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/data.json");
}

Future<File> getNameFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/name");
}

Future<void> readEntries() async {
  final file = await getDataFile();
  if (!await file.exists()) {
    entries = [];
  } else {
    final result = json.decode(await file.readAsString());
    entries = List.from(result.map((e) => Entry.fromJson(e)));
  }
  final nameFile = await getNameFile();
  if (await nameFile.exists()) {
    name = await nameFile.readAsString();
  }
}

void writeEntries() async {
  final file = await getDataFile();
  final result = json.encode(entries.map((e) => e.toJson()).toList());
  file.writeAsString(result);
}

void writeName() async {
  final file = await getNameFile();
  file.writeAsString(name);
}
