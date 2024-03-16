import 'dart:developer';

import 'package:atompaymentdemo/constant/constant.dart';
import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:atompaymentdemo/router/router.gr.dart';
import 'package:atompaymentdemo/widget/datefieldwidgetPublishFrom.dart';
import 'package:atompaymentdemo/widget/datefieldPublishTill.dart';
import 'package:atompaymentdemo/widget/noglow.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:readmore/readmore.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  String? _errorgazettetype;

  String? _errortitletext;

  var format = DateFormat("dd-MM-yyyy");

  DateTime? firstdate = DateTime(1950, 01, 01);

  DateTime? lastdate = DateTime.now();

  final int _rowsPerPage = 15;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titlecontoller = TextEditingController();

  TextEditingController gazettcontroller = TextEditingController();

  int? departmentdropdownid;
  String gazettetypename = '';
  String categoryname = '';

  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    GetxTapController gcontroller =
        Get.put(GetxTapController(context: context));

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
      body: GetBuilder<GetxTapController>(builder: (_) {
        return Obx(
          () => gcontroller.isDataLoading.value
              ?  const Center(child: CircularProgressIndicator())
              : gcontroller.isserverok
                  ? gcontroller.isdataempty?
                const Center(child: SizedBox())
                      : SafeArea(

                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 15, top: 15),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 12,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Search Result :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                ' ${gcontroller.allsearchdata.length} Record Found',
                                                style: const TextStyle(
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
                                                    builder: (BuildContext
                                                            context,
                                                        void Function(
                                                                void Function())
                                                            setState) {
                                                      return AlertDialog(
                                                        actions: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 19),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .grey,
                                                                        side: const BorderSide(
                                                                            color: Colors
                                                                                .red)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {
                                                                        // _namefieldcontroller.clear();
                                                                        // publishfromdate = '';

                                                                        // dropdownvalue1 = null;
                                                                        // dropdownvalue2 = null;
                                                                        // _position = null;
                                                                      });
                                                                    },
                                                                    child: const Text(
                                                                        "Cancel")),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10),
                                                                  child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                                                      onPressed: () {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          gcontroller.getFilterData(
                                                                              title: titlecontoller.text,
                                                                              gazettetype: gazettetypename,
                                                                              category: categoryname,
                                                                              deptid: departmentdropdownid);
                                                                          context
                                                                              .router
                                                                              .pop();
                                                                          // Do something with the validated form data
                                                                          print(
                                                                              'Form is valid');
                                                                        }
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
                                                                        //          '' dob: datetime,
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
                                                          ),
                                                        ],
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              "View Gazettes",
                                                            ),
                                                            GestureDetector(
                                                                onTap: () {},
                                                                child: const Icon(
                                                                    Icons
                                                                        .restore_outlined))
                                                          ],
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Form(
                                                            autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                            key: _formKey,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      'All :',
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Card(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(7)),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 253, 253, 252),
                                                                              borderRadius: BorderRadius.circular(7)),
                                                                          height:
                                                                              43,
                                                                          child:
                                                                              TextFormField(
                                                                            enabled:
                                                                                false,
                                                                            controller:
                                                                                TextEditingController(
                                                                              text: gcontroller.searchtextvalue,
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                                contentPadding: const EdgeInsets.only(top: 7, left: 10),
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                                                                                hintText: 'Type To Search',
                                                                                hintStyle: const TextStyle(color: Colors.grey)),
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
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      'Search By Title :',
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Card(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(7)),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: const Color.fromARGB(255, 253, 253, 252),
                                                                              borderRadius: BorderRadius.circular(7)),
                                                                          child:
                                                                              TextFormField(
                                                                            onChanged:
                                                                                gcontroller.validatetitle,
                                                                            controller:
                                                                                titlecontoller,
                                                                            validator:
                                                                                (value) {
                                                                              if (value == null || value.isEmpty) {
                                                                                return 'Please enter the title';
                                                                              }
                                                                              return null;
                                                                            },
                                                                            decoration: InputDecoration(
                                                                                contentPadding: const EdgeInsets.only(top: 7, left: 10),
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                                                                                hintText: 'Type To Search',
                                                                                hintStyle: const TextStyle(color: Colors.grey)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              4),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey)),
                                                                    child: DropdownSearch<
                                                                        String>(
                                                                      autoValidateMode:
                                                                          AutovalidateMode
                                                                              .onUserInteraction,
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty) {
                                                                          return 'Please select the Gazette Type';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      popupProps:
                                                                          PopupProps
                                                                              .menu(
                                                                        searchFieldProps: TextFieldProps(
                                                                            controller:
                                                                                gazettcontroller,
                                                                            decoration:
                                                                                const InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                        constraints: BoxConstraints.tight(Size(
                                                                            MediaQuery.of(context).size.width,
                                                                            160)),
                                                                        showSearchBox:
                                                                            true,
                                                                        showSelectedItems:
                                                                            true,
                                                                      ),
                                                                      items: const [
                                                                        'Ordinary',
                                                                        'Extra-Ordinary'
                                                                      ],
                                                                      dropdownDecoratorProps:
                                                                          const DropDownDecoratorProps(
                                                                        dropdownSearchDecoration:
                                                                            InputDecoration(
                                                                          labelText:
                                                                              "Gazette Type :",
                                                                          hintText:
                                                                              "Search Gazette Type",
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          gazettetypename =
                                                                              newValue!;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              4),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey)),
                                                                    child: DropdownSearch<
                                                                        String>(
                                                                      popupProps:
                                                                          PopupProps
                                                                              .menu(
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        searchFieldProps:
                                                                            const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                        constraints: BoxConstraints.tight(Size(
                                                                            MediaQuery.of(context).size.width,
                                                                            200)),
                                                                        showSearchBox:
                                                                            true,
                                                                        showSelectedItems:
                                                                            true,
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
                                                                          labelText:
                                                                              "Category :",
                                                                          hintText:
                                                                              "Select Category",
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          categoryname =
                                                                              newValue!;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      'Published From :',
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Card(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(7)),
                                                                        child: Container(
                                                                            decoration:
                                                                                BoxDecoration(color: const Color.fromARGB(255, 253, 253, 252), borderRadius: BorderRadius.circular(7)),
                                                                            height: 50,
                                                                            child: DateFieldWidgetpublishFrom()),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      'Published Till :',
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Card(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(7)),
                                                                        child: Container(
                                                                            decoration:
                                                                                BoxDecoration(color: const Color.fromARGB(255, 253, 253, 252), borderRadius: BorderRadius.circular(7)),
                                                                            height: 50,
                                                                            child: DateFieldWidgetpublishTill()),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              4),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey)),
                                                                    child: DropdownSearch<
                                                                        String>(
                                                                      popupProps:
                                                                          PopupProps
                                                                              .menu(
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        searchFieldProps:
                                                                            const TextFieldProps(decoration: InputDecoration(border: OutlineInputBorder(), constraints: BoxConstraints(maxHeight: 40))),
                                                                        constraints: BoxConstraints.tight(Size(
                                                                            MediaQuery.of(context).size.width,
                                                                            250)),
                                                                        showSearchBox:
                                                                            true,
                                                                        showSelectedItems:
                                                                            true,
                                                                      ),
                                                                      items: gcontroller
                                                                          .alldepartmentlist,
                                                                      dropdownDecoratorProps:
                                                                          const DropDownDecoratorProps(
                                                                        dropdownSearchDecoration:
                                                                            InputDecoration(
                                                                          labelText:
                                                                              "Department :",
                                                                          hintText:
                                                                              "Select Department",
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        int index = gcontroller
                                                                            .alldepartmentlist
                                                                            .indexOf(newValue!);
                                                                        setState(
                                                                            () {
                                                                          departmentdropdownid = gcontroller
                                                                              .alldepartment[index]
                                                                              .id;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
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
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                      Expanded(
                                        flex: 160,
                                        child: gcontroller.isfiltersearch?const Center(child: Text('No Record Found',style: TextStyle(fontSize: 20),),)
                      :   
                                        
                                         ScrollConfiguration(
                                          behavior: NoGlowScrollBehavior(),
                                          child: SfDataGridTheme(
                                            data: SfDataGridThemeData(rowHoverTextStyle: const TextStyle(fontFamily: 'KulimPark'),
                                              headerColor: Colors.green[50],
                                              gridLineColor: Colors.grey,
                                            ),
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 10,
                                              child: SfDataGrid(
                                                // onQueryRowHeight: 
                                                
                                                // (details) {
                                                //   return details
                                                //       .getIntrinsicRowHeight(details.rowIndex);
                                                // },
                                                rowHeight: 82,
                                                verticalScrollPhysics:
                                                    const ClampingScrollPhysics(),
                                                horizontalScrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                             
                                                gridLinesVisibility:
                                                    GridLinesVisibility.both,
                                                headerGridLinesVisibility:
                                                    GridLinesVisibility.both,
                                                source: gcontroller
                                                    .employeeDataSource!,
                                                columns: <GridColumn>[
                                                  GridColumn(
                                                      columnWidthMode:
                                                          ColumnWidthMode
                                                              .lastColumnFill,
                                                      columnName: 'title',
                                                      label: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          'Title',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'KulimPark',
                                                          ),
                                                        ),
                                                      )),
                                                  GridColumn(
                                                      minimumWidth: 100,
                                                      columnName: 'gazetid',
                                                      label: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: const Text(
                                                          'Publication Date',
                                                          overflow: TextOverflow
                                                              .visible,textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'KulimPark',
                                                          ),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                       Expanded(
                                        flex: 15,
                                        child:         gcontroller.isfiltersearch?const SizedBox()
                      :
                                        
                                         Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            height: _dataPagerHeight,
                                            child: Center(
                                              child: SfDataPager(
                                                lastPageItemVisible: true,
                                                firstPageItemVisible: true,
                                                nextPageItemVisible: true,
                                                previousPageItemVisible: true,
                                                visibleItemsCount: 5,
                                                onRowsPerPageChanged: (value) {
                                                  gcontroller
                                                      .handlePageChange(value!);
                                                },
                                                delegate: gcontroller
                                                    .employeeDataSource!,
                                                pageCount: gcontroller
                                                                .allsearchdata
                                                                .length %
                                                            _rowsPerPage ==
                                                        0
                                                    ? (gcontroller.allsearchdata
                                                            .length /
                                                        _rowsPerPage)
                                                    : (gcontroller.allsearchdata
                                                                .length /
                                                            _rowsPerPage) +
                                                        1,
                                                direction: Axis.horizontal,
                                              ),
                                            )),
                                      )
                              ],
                            ),
                          ),
                        )
                  : Center(
                      child: SizedBox(
                        height: 170,
                        child: Image.asset('assets/images/servererror.png'),
                      ),
                    ),
        );
      }),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  final BuildContext context;
  EmployeeDataSource(
      {required this.context, required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'title', value: dataGridRow.title),
              DataGridCell<String>(
                  columnName: 'publicationdate', value: dataGridRow.publidate),
            
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(
    DataGridRow row,
  ) {
    GetxTapController gcontroller =
        Get.put(GetxTapController(context: context));
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      
      return Container(
          alignment: (dataGridCell.columnName == 'gazettenumber' ||
                  dataGridCell.columnName == 'gazetid')
              ? Alignment.center
              : Alignment.centerLeft,
          child: dataGridCell.columnName == 'title'
              ? Column(crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                          onPressed: () {
                        
                      
                            gcontroller.getGazetteDetails(
                                titlename: dataGridCell.value.toString());
                      
                            context.router.push(BillingPage());
                          },
                          child: Text(textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis,
                    dataGridCell.value.toString(),maxLines: 3,)
                    //       ReadMoreText(textAlign: TextAlign.justify,
                    // dataGridCell.value.toString(),
                                       
                                      
                                     
                    //                     style: const TextStyle(color: Colors.blue),
                    //                     colorClickableText: Colors.pink,
                    //                     trimMode: TrimMode.Line,
                    //                     trimCollapsedText: '...Show more',
                    //                     trimExpandedText: ' show less',
                    //                     callback: (val) {
                                          
                    //                     },
                                  
                                 
                                
                    //                   ),
                          
                                  ),
            dataGridCell.value.toString().length>130?   GestureDetector(onTap: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // Return an AlertDialog object
                return AlertDialog(
               title: Text(dataGridCell.value.toString(),textAlign: TextAlign.justify,style: const TextStyle(fontSize: 13),),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );});
            
            
            }, child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('See more',style: TextStyle(color: Colors.red,fontFamily: 'KulimPark'),),
            )):const SizedBox()
              
                ],
              )
          
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    dataGridCell.value.toString(),
            
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontFamily: 'KulimPark',
                    ),
                  ),
                ));
    }).toList());
  }
}

class Employee {
  Employee({
    required this.title,
    required this.publidate,
  });

  final String title;

  final String publidate;
}
