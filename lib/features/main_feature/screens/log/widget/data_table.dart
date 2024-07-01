import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LogDataTable extends StatefulWidget {
  const LogDataTable({super.key, this.log});
  final Map<String, dynamic>? log;

  @override
  State<LogDataTable> createState() => _LogDataTableState();
}

class _LogDataTableState extends State<LogDataTable> {
  bool sortAscending = true;
  late List<Log> logList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logList = widget.log!.entries
        .map((e) => Log(studentCode: e.key, time: e.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<DataRow> dataRows = logList.map((entry) {
      index++;
      return DataRow(
        cells: [
          DataCell(
            Text(
              index.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.035),
            ),
          ), // STT
          DataCell(
            Text(
              entry.studentCode,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.035),
            ),
          ), // MSSV
          DataCell(
            Text(
              AppFormatter.formatTimeStampToDate(entry.time),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.035),
            ),
          ), // Thời gian
        ],
      );
    }).toList();
    return DataTable(
      columns: [
        const DataColumn(
          label: Expanded(
            child: Text(
              'STT',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn(
          label: Expanded(
            child: Text(
              'MSSV',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: const Expanded(
            child: Text(
              'Thời gian',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          onSort: (columnIndex, ascending) {
            setState(() {
              sortAscending = !sortAscending;
              logList.sort((a, b) => a.time.compareTo(b.time));
              if (!sortAscending) {
                logList = logList.reversed.toList();
              }
            });
          },
        ),
      ],
      rows: dataRows,
      sortColumnIndex: 2,
      sortAscending: sortAscending,
    );
  }
}

class Log {
  final String studentCode;
  final Timestamp time;

  Log({required this.studentCode, required this.time});
}
