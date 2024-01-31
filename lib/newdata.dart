import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

@RoutePage()
class MyDataGrid extends StatefulWidget {
  const MyDataGrid({super.key});

  @override
  _MyDataGridState createState() => _MyDataGridState();
}

class _MyDataGridState extends State<MyDataGrid> {
  late EmployeeDataSource _employeeDataSource;

  List<Employee> _employees = <Employee>[];
  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
        10001,
        'James ffsfdsdsgds fsffsfaf',
        'Project Lead',
      ),
      Employee(
        10002,
        'Kathryn',
        'Manager',
      ),
      Employee(
        10003,
        'Lara',
        'Developer',
      ),
      Employee(
        10004,
        'Michael',
        'Designer',
      ),
      Employee(
        10005,
        'Martin',
        'Developer',
      ),
      Employee(
        10006,
        'Newberry',
        'Developer',
      ),
      Employee(
        10007,
        'Balnc',
        'Developer',
      ),
      Employee(
        10008,
        'Perry',
        'Developer',
      ),
      Employee(
        10009,
        'Gable',
        'Developer',
      ),
      Employee(
        10010,
        'Grimes',
        'Developer',
      ),
      Employee(
        10011,
        'Martin',
        'Developer',
      ),
      Employee(
        10012,
        'Newberry',
        'Developer',
      ),
      Employee(
        10013,
        'Balnc',
        'Developer',
      ),
      Employee(
        10014,
        'Perry',
        'Developer',
      ),
      Employee(
        10015,
        'Gable',
        'Developer',
      ),
      Employee(
        10016,
        'Grimes',
        'Developer',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Image.asset(
            'assets/images/kanglasa.png',
          ),
        ),
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Manipur e-Gazette',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Search Result :',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text(
                        ' 34 Record Found',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.filter_alt_rounded,
                        color: Colors.blue,
                      ),
                      Text('Filter'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SfDataGridTheme(
                data: SfDataGridThemeData(
                  headerColor: Colors.green[50],
                  currentCellStyle: const DataGridCurrentCellStyle(
                      borderColor: Colors.amber, borderWidth: 2),
                  gridLineColor: Colors.grey,
                  headerHoverColor: Colors.red,
                ),
                child: Expanded(
                  child: SfDataGrid(
                    columnWidthMode: ColumnWidthMode.lastColumnFill,
                    columnSizer: ColumnSizer(),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    source: _employeeDataSource,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'id',
                          label: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Gazette No',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.fill,
                          columnName: 'name',
                          label: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Title',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                      GridColumn(
                          columnName: 'designation',
                          label: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Total Pages',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                      GridColumn(
                          columnName: 'salary',
                          label: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'View',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // List<Map<String, dynamic>> getEmployeeData(int count) {
  //   List<Map<String, dynamic>> employeeData = [];
  //   for (int i = 1; i <= count; i++) {
  //     employeeData.add({
  //       'id': 1000 + i,
  //       'name': 'Employee $i',
  //       'designation': 'Designation $i',
  //       'salary': 50000 + i * 1000,
  //     });
  //   }

  //   return employeeData;
  // }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              const DataGridCell<Widget>(columnName: 'salary', value: null),
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
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: dataGridCell.columnName == 'salary'
              ? TextButton(onPressed: () {}, child: const Text('View Gazette'))
              : Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ));
    }).toList());
  }
}

class Employee {
  Employee(
    this.id,
    this.name,
    this.designation,
  );
  final int id;
  final String name;
  final String designation;
}
