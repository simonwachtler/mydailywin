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

Future<File> getFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/data.json");
}

void readEntries() async {
  final file = await getFile();
  final result = json.decode(await file.readAsString());
  entries = result.map((e) => Entry.fromJson(e)).toList();
}

void writeEntries() async {
  final file = await getFile();
  final result = json.encode(entries.map((e) => e.toJson()).toList());
  file.writeAsString(result);
}
