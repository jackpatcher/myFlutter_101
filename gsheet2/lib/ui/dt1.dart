import 'package:flutter/material.dart';
import 'package:gsheet2/models/std.dart';
import 'package:gsheet2/services/gsheet.dart';
import 'package:pluto_grid/pluto_grid.dart';

// /**
//  * Source
//  *  https://pub.dev/packages/pluto_grid/example
//  *
//  */
class Dt1 extends StatefulWidget {
  final GoogleSheetsProvider provider;
  const Dt1({
    required this.provider,
    Key? key,
  }) : super(key: key);

  @override
  Dt1State createState() => Dt1State();
}

class Dt1State extends State<Dt1> {
  Future<List<Std>> get stds => widget.provider.getStd();

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'ชื่อ',
      field: 'fname',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'สกุล',
      field: 'lname',
      type: PlutoColumnType.text(),
    ),
  ];

  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("DataTable"),
        ),
        body: FutureBuilder<List<Std>>(
          future: stds,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final stds = snapshot.data!;

            return Container(
                padding: const EdgeInsets.all(15),
                child: PlutoGrid(
                  columns: columns,
                  rows: addstdRow(stds)!,
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    event.stateManager.setShowColumnFilter(true);
                  },
                  onChanged: (PlutoGridOnChangedEvent event) {
                    print(event);
                  },
                  configuration: const PlutoGridConfiguration(
    
                  ),
                ));
          },
        ));
  }

  List<PlutoRow>? addstdRow(List<Std> stds) {
    List<PlutoRow> row = [];

    for (var std in stds) {
      row.add(PlutoRow(
        cells: {
          'fname': PlutoCell(value: std.firstName),
          'lname': PlutoCell(value: std.lastName),
        },
      ));
    }

    return row;
  }
}
