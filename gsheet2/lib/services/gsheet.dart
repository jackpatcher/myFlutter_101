import 'package:gsheets/gsheets.dart';
import 'package:gsheet2/models/std.dart';

class GoogleSheetsProvider {
  final GSheets _gsheets;

  late Worksheet _worksheet;

  GoogleSheetsProvider(String credentials) : _gsheets = GSheets(credentials);

  Future<void> initializeForWorksheet(      String spreadsheetId, String worksheetTitle) async {
    final excel = await _gsheets.spreadsheet(spreadsheetId);
    _worksheet = excel.worksheetByTitle(worksheetTitle)!;
  }

  Future <List <Std> > getStd() async {
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(3).toList();
    var a = values.map((value) => 
          Std.fromSheets(value)
      ).toList();
    print(values);
 
    return a;
  }

  Future<bool> deleteStd(int index) {
    /// We add one to the index so that we can:
    /// 1. Start at index 1
    /// 2. Skip the first row
    return _worksheet.deleteRow(index + 2);
  }

  Future<bool> addStd(String firstName, String lastName) {
    return _worksheet.values.appendRow([firstName, lastName]);
  }
}