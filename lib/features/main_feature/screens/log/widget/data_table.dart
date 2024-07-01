import 'package:flutter/material.dart';

class LogDataTable extends StatelessWidget {
  const LogDataTable({super.key, this.log});
  final Map<String, dynamic>? log;
  @override
  Widget build(BuildContext context) {
    // Map log entries to DataRow objects
    int index = 0;
    List<DataRow> dataRows = log!.entries.map((entry) {
      var data = entry.value;
      index++;
      return DataRow(
        cells: [
          DataCell(Text(index.toString())), // STT
          DataCell(Text(entry.key)), // MSSV
          DataCell(Text(data?.toDate().toString() ?? '')), // Thời gian
        ],
      );
    }).toList();
    return DataTable(columns: const <DataColumn>[
      DataColumn(
        label: Expanded(
          child: Text(
            'STT',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'MSSV',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Thời gian',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
    ], rows: dataRows);
  }
}
