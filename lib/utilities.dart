import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;

  File file = File('$path/account.json');
  if (!file.existsSync()) {
    await file.create(exclusive: false);
    String jsonString = await rootBundle.loadString('assets/rollList.json');
    await file.writeAsString(jsonString);
  }

  return file;
}
