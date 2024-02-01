import 'dart:developer';

import 'package:atompaymentdemo/constant/constant.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

@RoutePage()
class MyDataGrid extends StatefulWidget {
  const MyDataGrid({super.key});

  @override
  _MyDataGridState createState() => _MyDataGridState();
}

class _MyDataGridState extends State<MyDataGrid> {
  late EmployeeDataSource _employeeDataSource;

  final List<Employee> _employees = <Employee>[];

  @override
  void initState() {
    super.initState();
    gettodaydate();
    getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  getEmployeeData() {
    for (int i = 0; i < alldata.length; i++) {
      _employees.add(Employee(
        alldata[i]['id'],
        alldata[i]['name'],
        alldata[i]['designation'],
      ));
    }
  }

  gettodaydate() {
    DateTime now = DateTime.now();

    int day = now.day;
    int month = now.month;
    int year = now.year;
    setState(() {
      publishtillcontroller = TextEditingController(text: '$day-$month-$year');
      publishTilldate = '$day-$month-$year';
    });
  }

  var format = DateFormat("dd-MM-yyyy");
  DateTime? firstdate = DateTime(1950, 01, 01);
  DateTime? lastdate = DateTime.now();
//PublishTill
  TextEditingController publishtillcontroller = TextEditingController();
  String publishTilldate = '';

  DateTime? publishTillinitialdate = DateTime.now();

//PublishFrom
  TextEditingController publishfromcontroller =
      TextEditingController(text: '01-01-1950');
  String publishfromdate = '01-01-1950';

  DateTime? publishfrominitialdate = DateTime(1950, 01, 01);

  Widget _dataofbirth({
    required TextEditingController controller,
    required String date,
    required DateTime initialdate,
  }) {
    return DateTimeField(
      resetIcon: const Icon(Icons.restore),
      onChanged: (value) {
        setState(() {
          // datetime = "${value!.year}-${value.month}-${value.day}";
          date = "${value!.day}-${value.month}-${value.year}";
        });
      },
      readOnly: false,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () async {
              return showDatePicker(
                      context: context,
                      initialDate: initialdate,
                      firstDate: firstdate!,
                      lastDate: lastdate!,
                      // helpText: "SELECT DATE OF BIRTH",
                      cancelText: "CANCEL",
                      confirmText: "OK",
                      fieldHintText: "DATE/MONTH/YEAR",
                      fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                      errorFormatText: "Enter a Valid Date",
                      errorInvalidText: "Date Out of Range")
                  .then((value) {
                setState(() {
                  // datetime = "${value!.year}-${value.month}-${value.day}";
                  controller.text =
                      "${value!.day}-${value.month}-${value.year}";
                });

                return value;
              });
            },
            icon: const Icon(Icons.calendar_today),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
                context: context,
                initialDate: initialdate,
                firstDate: firstdate!,
                lastDate: lastdate!,
                // helpText: "SELECT DATE OF BIRTH",
                cancelText: "CANCEL",
                confirmText: "OK",
                fieldHintText: "DATE/MONTH/YEAR",
                fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                errorFormatText: "Enter a Valid Date",
                errorInvalidText: "Date Out of Range")
            .then((value) {
          setState(() {
            // datetime = "${value!.year}-${value.month}-${value.day}";
            date = "${value!.day}-${value.month}-${value.year}";
          });

          return value;
        });
      },
    );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
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
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (cnt) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return AlertDialog(
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey,
                                              side: const BorderSide(
                                                  color: Colors.red)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              // _namefieldcontroller.clear();
                                              // publishfromdate = '';

                                              // dropdownvalue1 = null;
                                              // dropdownvalue2 = null;
                                              // _position = null;
                                            });
                                          },
                                          child: const Text("Cancel")),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue),
                                            onPressed: () async {
                                              // EasyLoading.show(status: 'Adding..');
                                              // if (_namefieldcontroller.text.isEmpty ||
                                              //     dropdownvalue11 == null ||
                                              //     dropdownvalue22 == null ||
                                              //     datetime.isEmpty ||
                                              //     profileimage.isEmpty ||
                                              //     finallocation == null) {
                                              //   EasyLoading.dismiss();
                                              //   context.router.pop();
                                              //   CustomSnackBar(
                                              //       context,
                                              //       Text(
                                              //         'All Fields Are Mandatory',
                                              //         style:
                                              //       ),
                                              //       Colors.red);
                                              // } else {
                                              //   await ServiceApi()
                                              //       .create_employee(
                                              //           name: _namefieldcontroller.text,
                                              //           desId: dropdownvalue11!,
                                              //           depId: dropdownvalue22!,
                                              //           dob: datetime,
                                              //           token: finaltoken,
                                              //           image: profileimage,
                                              //           location: finallocation!)
                                              //       .whenComplete(() {
                                              //     getdata2().whenComplete(() {
                                              //       _namefieldcontroller.clear();
                                              //       all_desid = [];
                                              //       all_depid = [];
                                              //       all_dep = [];
                                              //       all_des = [];
                                              //       _position = null;
                                              //       publishfromdate = '';

                                              //       dropdownvalue1 = null;
                                              //       dropdownvalue2 = null;
                                              //       setState(() {});

                                              //       getcreate_status();
                                              //       getdata();
                                              //       EasyLoading.dismiss();
                                              //       context.router.pop();
                                              //     });
                                              //   });
                                              //   log(create_statuscode.toString());
                                              // }
                                            },
                                            child: const Text("Search")),
                                      )
                                    ],
                                  ),
                                ],
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "View Gazettes",
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child:
                                            const Icon(Icons.restore_outlined))
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: Form(
                                    child: SizedBox(
                                      height: 460,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'All :',
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Expanded(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 253, 253, 252),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7)),
                                                    height: 43,
                                                    child: TextFormField(
                                                      onChanged: ((value) {}),
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 7,
                                                                  left: 10),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7)),
                                                          hintText:
                                                              'Type To Search',
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Search By Title :',
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Expanded(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 253, 253, 252),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7)),
                                                    height: 43,
                                                    child: TextFormField(
                                                      onChanged: ((value) {}),
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 7,
                                                                  left: 10),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7)),
                                                          hintText:
                                                              'Type To Search',
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: DropdownSearch<String>(
                                              popupProps: PopupProps.menu(
                                                searchFieldProps: const TextFieldProps(
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight:
                                                                    40))),
                                                constraints:
                                                    BoxConstraints.tight(Size(
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        160)),
                                                showSearchBox: true,
                                                showSelectedItems: true,
                                              ),
                                              items: const [
                                                'Ordinary',
                                                'Extra-Ordinary'
                                              ],
                                              dropdownDecoratorProps:
                                                  const DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelText: "Gazette Type :",
                                                  hintText:
                                                      "Search Gazette Type",
                                                ),
                                              ),
                                              // onChanged: (String? newValue) {
                                              //   setState(() {
                                              //     dropdownvalue1 = newValue as String;
                                              //   });
                                              //   int ind = all_des.indexOf(dropdownvalue1!);
                                              //   dropdownvalue11 = all_desid[ind];
                                              // },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: DropdownSearch<String>(
                                              popupProps: PopupProps.menu(
                                                fit: FlexFit.tight,
                                                searchFieldProps: const TextFieldProps(
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight:
                                                                    40))),
                                                constraints:
                                                    BoxConstraints.tight(Size(
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        200)),
                                                showSearchBox: true,
                                                showSelectedItems: true,
                                              ),
                                              items: const [
                                                'Govt to Citizen',
                                                'Govt to Employee',
                                                'Govt to Govt',
                                              ],
                                              dropdownDecoratorProps:
                                                  const DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelText: "Category :",
                                                  hintText: "Select Category",
                                                ),
                                              ),
                                              // onChanged: (String? newValue) {
                                              //   setState(() {
                                              //     dropdownvalue2 = newValue as String;
                                              //   });
                                              //   int ind = all_dep.indexOf(dropdownvalue2!);
                                              //   dropdownvalue22 = all_depid[ind];
                                              // },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Published From :',
                                              ),
                                              Expanded(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              253, 253, 252),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      height: 43,
                                                      child: _dataofbirth(
                                                        controller:
                                                            publishfromcontroller,
                                                        date: publishfromdate,
                                                        initialdate:
                                                            publishfrominitialdate!,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Published Till :',
                                              ),
                                              Expanded(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              253, 253, 252),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      height: 43,
                                                      child: _dataofbirth(
                                                        controller:
                                                            publishtillcontroller,
                                                        date: publishTilldate,
                                                        initialdate:
                                                            publishTillinitialdate!,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: DropdownSearch<String>(
                                              popupProps: PopupProps.menu(
                                                fit: FlexFit.tight,
                                                searchFieldProps: const TextFieldProps(
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight:
                                                                    40))),
                                                constraints:
                                                    BoxConstraints.tight(Size(
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        250)),
                                                showSearchBox: true,
                                                showSelectedItems: true,
                                              ),
                                              items: const [
                                                'Govt to Citizen',
                                                'Govt to Employee',
                                                'Govt to Govt',
                                              ],
                                              dropdownDecoratorProps:
                                                  const DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelText: "Department :",
                                                  hintText: "Select Department",
                                                ),
                                              ),
                                              // onChanged: (String? newValue) {
                                              //   setState(() {
                                              //     dropdownvalue2 = newValue as String;
                                              //   });
                                              //   int ind = all_dep.indexOf(dropdownvalue2!);
                                              //   dropdownvalue22 = all_depid[ind];
                                              // },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.filter_alt_rounded,
                          color: Colors.blue,
                        ),
                        Text('Filter'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SfDataGridTheme(
                data: SfDataGridThemeData(
                  headerColor: Colors.green[50],
                  gridLineColor: Colors.grey,
                ),
                child: Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
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
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontFamily: 'KulimPark',
                                ),
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
                                style: TextStyle(
                                  fontFamily: 'KulimPark',
                                ),
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
                                style: TextStyle(
                                  fontFamily: 'KulimPark',
                                ),
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
                                style: TextStyle(
                                  fontFamily: 'KulimPark',
                                ),
                              ),
                            ))
                      ],
                    ),
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
              ? Alignment.center
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: dataGridCell.columnName == 'salary'
              ? TextButton(onPressed: () {}, child: const Text('View Gazette'))
              : Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: 'KulimPark',
                  ),
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