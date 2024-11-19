import 'package:flutter/material.dart';
import 'package:income_tally/widgets/rounded_container.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<StatefulWidget> createState() => TablePageState();
}

class TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        RoundedContainer(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            //columnSpacing: 20,
            //headingRowHeight: 50,
            //dataRowMinHeight: 40,
            //border: TableBorder.all(color: Colors.grey.shade300), // Add border around the table
            columns: _createColumns(),
            rows: _createRows(),
          ),
        ),
      ],
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Column 1')),
      const DataColumn(label: Text('Column 2')),
      const DataColumn(label: Text('Column 3')),
      const DataColumn(label: Text('Column 4')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      const DataRow(cells: [
        DataCell(Text('Row 1, Col 1')),
        DataCell(Text('Row 1, Col 2')),
        DataCell(Text('Row 1, Col 3')),
        DataCell(Text('Row 1, Col 4')),
      ]),
      const DataRow(cells: [
        DataCell(Text('Row 2, Col 1')),
        DataCell(Text('Row 2, Col 2')),
        DataCell(Text('Row 2, Col 3')),
        DataCell(Text('Row 2, Col 4')),
      ]),
      const DataRow(cells: [
        DataCell(Text('Row 3, Col 1')),
        DataCell(Text('Row 3, Col 2')),
        DataCell(Text('Row 3, Col 3')),
        DataCell(Text('Row 3, Col 4')),
      ]),
      const DataRow(cells: [
        DataCell(Text('Row 4, Col 1')),
        DataCell(Text('Row 4, Col 2')),
        DataCell(Text('Row 4, Col 3')),
        DataCell(Text('Row 4, Col 4')),
      ]),
      const DataRow(cells: [
        DataCell(Text('Row 5, Col 1')),
        DataCell(Text('Row 5, Col 2')),
        DataCell(Text('Row 5, Col 3')),
        DataCell(Text('Row 5, Col 4')),
      ]),
    ];
  }
}