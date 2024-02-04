// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// const int _rowsPerPage = 15;

// const double _dataPagerHeight = 60.0;

// List<OrderInfo> _orders = [];

// List<OrderInfo> _paginatedOrders = [];

// final OrderInfoDataSource _orderInfoDataSource = OrderInfoDataSource();

// @override
// Widget build(BuildContext context) {
//   return LayoutBuilder(builder: (context, constraint) {
//     return Column(children: [
//       SizedBox(
//           height: constraint.maxHeight - _dataPagerHeight,
//           width: constraint.maxWidth,
//           child: _buildDataGrid(constraint)),
//       SizedBox(
//           height: _dataPagerHeight,
//           child: SfDataPager(
//             delegate: _orderInfoDataSource,
//             pageCount: _orders.length / _rowsPerPage,
//             direction: Axis.horizontal,
//           ))
//     ]);
//   });
// }

// Widget _buildDataGrid(BoxConstraints constraint) {
//   return SfDataGrid(
//       source: _orderInfoDataSource,
//       columnWidthMode: ColumnWidthMode.fill,
//       columns: <GridColumn>[
//         GridColumn(
//             columnName: 'orderID',
//             label: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 alignment: Alignment.centerRight,
//                 child: const Text(
//                   'Order ID',
//                   overflow: TextOverflow.ellipsis,
//                 ))),
//         GridColumn(
//             columnName: 'customerID',
//             label: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 alignment: Alignment.centerLeft,
//                 child: const Text(
//                   'Customer Name',
//                   overflow: TextOverflow.ellipsis,
//                 ))),
//         GridColumn(
//             columnName: 'orderDate',
//             label: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 alignment: Alignment.centerRight,
//                 child: const Text(
//                   'Order Date',
//                   overflow: TextOverflow.ellipsis,
//                 ))),
//         GridColumn(
//             columnName: 'freight',
//             label: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   'Freight',
//                   overflow: TextOverflow.ellipsis,
//                 )))
//       ]);
// }

// class OrderInfoDataSource extends DataGridSource {
//   OrderInfoDataSource() {
//     _paginatedOrders = _orders.getRange(0, 19).toList(growable: false);
//     buildPaginatedDataGridRows();
//   }

//   List<DataGridRow> dataGridRows = [];

//   @override
//   List<DataGridRow> get rows => dataGridRows;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       if (dataGridCell.columnName == 'orderID') {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           alignment: Alignment.centerRight,
//           child: Text(
//             dataGridCell.value.toString(),
//             overflow: TextOverflow.ellipsis,
//           ),
//         );
//       } else if (dataGridCell.columnName == 'customerID') {
//         return Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               dataGridCell.value.toString(),
//               overflow: TextOverflow.ellipsis,
//             ));
//       } else if (dataGridCell.columnName == 'orderDate') {
//         return Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             alignment: Alignment.centerRight,
//             child: Text(
//               DateFormat.yMd().format(dataGridCell.value).toString(),
//               overflow: TextOverflow.ellipsis,
//             ));
//       } else {
//         return Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             alignment: Alignment.center,
//             child: Text(
//               NumberFormat.currency(locale: 'en_US', symbol: '\$')
//                   .format(dataGridCell.value)
//                   .toString(),
//               overflow: TextOverflow.ellipsis,
//             ));
//       }
//     }).toList());
//   }

//   @override
//   Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
//     int startIndex = newPageIndex * _rowsPerPage;
//     int endIndex = startIndex + _rowsPerPage;
//     if (startIndex < _orders.length && endIndex <= _orders.length) {
//       _paginatedOrders =
//           _orders.getRange(startIndex, endIndex).toList(growable: false);
//       buildPaginatedDataGridRows();
//       notifyListeners();
//     } else {
//       _paginatedOrders = [];
//     }

//     return true;
//   }

//   void buildPaginatedDataGridRows() {
//     dataGridRows = _paginatedOrders.map<DataGridRow>((dataGridRow) {
//       return DataGridRow(cells: [
//         DataGridCell(columnName: 'orderID', value: dataGridRow.orderID),
//         DataGridCell(columnName: 'customerID', value: dataGridRow.customerID),
//         DataGridCell(columnName: 'orderDate', value: dataGridRow.orderDate),
//         DataGridCell(columnName: 'freight', value: dataGridRow.freight),
//       ]);
//     }).toList(growable: false);
//   }
// }
