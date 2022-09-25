import 'package:flutter/material.dart';
import 'package:gsheet2/config/secret.dart';
import 'package:gsheet2/services/gsheet.dart';
import 'package:gsheet2/ui/app.dart';

void main() async {
  final sheet = GoogleSheetsProvider(credentials);

  /// Initialize provider
  await sheet.initializeForWorksheet(sheetId, worksheetTitle);

  runApp(SheetsApp(
    sheet: sheet,
  ));
}
