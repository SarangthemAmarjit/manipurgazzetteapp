import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

@RoutePage()
class MyDataGrid extends StatefulWidget {
  const MyDataGrid({super.key});

  @override
  _MyDataGridState createState() => _MyDataGridState();
}

class _MyDataGridState extends State<MyDataGrid> {
  late List<Employee> employees;
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployees(50);
    employeeDataSource = EmployeeDataSource(employees);
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
      body: SfDataGrid(
        source: employeeDataSource,
        columns: <GridColumn>[
          GridColumn(columnName: '1', label: const Text('Data1')),
          GridColumn(columnName: '2', label: const Text('Data2')),
          GridColumn(columnName: '3', label: const Text('Data3')),
          GridColumn(columnName: '4', label: const Text('Data4'))
        ],
      ),
    );
  }

  List<Employee> getEmployees(int count) {
    List<Employee> employeeData = [];
    for (int i = 1; i <= count; i++) {
      employeeData.add(Employee(
        id: 1000 + i,
        name: 'Employee $i',
        designation: 'Designation $i',
        salary: 50000 + i * 1000,
      ));
    }
    return employeeData;
  }
}

class Employee {
  Employee(
      {required this.id,
      required this.name,
      required this.designation,
      required this.salary});

  final int id;
  final String name;
  final String designation;
  final double salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(this.employees);

  List<Employee> employees;

  @override
  List<Object> get dataSource => employees;

  @override
  Object getValue(Object dataObject, String columnName) {
    switch (columnName) {
      case 'id':
        return (dataObject as Employee).id;
      case 'name':
        return (dataObject as Employee).name;
      case 'designation':
        return (dataObject as Employee).designation;
      case 'salary':
        return (dataObject as Employee).salary;
      default:
        return '';
    }
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    throw UnimplementedError();
  }
}
