import 'package:flutter/material.dart';
import 'package:qld_covid_map/models/exposure.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ExposureList extends StatelessWidget {
  ExposureList(this.dataSource, {Key? key}) : super(key: key);
  final ExposureDataSource dataSource;

  final List<String> columns = ["Date", "Added", "Place", "Suburb", "Time", "Category"];

  GridColumn makeGridColumn(String name) => GridColumn(
      allowSorting: true,
      columnName: name,
      label: Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerRight,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
          )));

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      allowSorting: true,
      columnWidthMode: ColumnWidthMode.fill,
      source: dataSource,
      columns: columns.map<GridColumn>((name) => makeGridColumn(name)).toList(),
    );
  }
}

class ExposureDataSource extends DataGridSource {
  ExposureDataSource({required List<Exposure> exposures}) {
    dataGridRows = exposures
        .map<DataGridRow>((exposure) => DataGridRow(cells: [
              DataGridCell<DateTime>(columnName: "Date", value: exposure.date),
              DataGridCell<DateTime>(columnName: "Added", value: exposure.dateAdded),
              DataGridCell<String>(columnName: "Place", value: exposure.place),
              DataGridCell<String>(columnName: "Suburb", value: exposure.suburb),
              DataGridCell<String>(columnName: "Time", value: exposure.time),
              DataGridCell<ExposureType>(columnName: "Category", value: exposure.type),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
