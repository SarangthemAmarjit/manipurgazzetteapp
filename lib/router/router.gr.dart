// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:atompaymentdemo/pages/billingpage.dart' as _i1;
import 'package:atompaymentdemo/pages/Dashboard.dart' as _i2;
import 'package:atompaymentdemo/pages/infopage.dart' as _i3;
import 'package:atompaymentdemo/pages/PaymentPage.dart' as _i4;
import 'package:atompaymentdemo/pages/searchpage.dart' as _i5;
import 'package:atompaymentdemo/pages/successpage.dart' as _i6;
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    BillingPage.name: (routeData) {
      final args = routeData.argsAs<BillingPageArgs>(
          orElse: () => const BillingPageArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BillingPage(key: args.key),
      );
    },
    DashBoardPage.name: (routeData) {
      final args = routeData.argsAs<DashBoardPageArgs>(
          orElse: () => const DashBoardPageArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DashBoardPage(key: args.key),
      );
    },
    InfoPage.name: (routeData) {
      final args = routeData.argsAs<InfoPageArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.InfoPage(
          key: args.key,
          index: args.index,
        ),
      );
    },
    PaymentPage.name: (routeData) {
      final args = routeData.argsAs<PaymentPageArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PaymentPage(
          args.mode,
          args.payDetails,
          args.responsehashKey,
          args.responseDecryptionKey,
          key: args.key,
        ),
      );
    },
    SearchPage.name: (routeData) {
      final args = routeData.argsAs<SearchPageArgs>(
          orElse: () => const SearchPageArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SearchPage(key: args.key),
      );
    },
    SuccessPage.name: (routeData) {
      final args = routeData.argsAs<SuccessPageArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SuccessPage(
          key: args.key,
          transactionstatus: args.transactionstatus,
          transactionid: args.transactionid,
          trasactionstatus: args.trasactionstatus,
          paymentmethodname: args.paymentmethodname,
          totalamount: args.totalamount,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.BillingPage]
class BillingPage extends _i7.PageRouteInfo<BillingPageArgs> {
  BillingPage({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          BillingPage.name,
          args: BillingPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BillingPage';

  static const _i7.PageInfo<BillingPageArgs> page =
      _i7.PageInfo<BillingPageArgs>(name);
}

class BillingPageArgs {
  const BillingPageArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'BillingPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.DashBoardPage]
class DashBoardPage extends _i7.PageRouteInfo<DashBoardPageArgs> {
  DashBoardPage({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DashBoardPage.name,
          args: DashBoardPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DashBoardPage';

  static const _i7.PageInfo<DashBoardPageArgs> page =
      _i7.PageInfo<DashBoardPageArgs>(name);
}

class DashBoardPageArgs {
  const DashBoardPageArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'DashBoardPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.InfoPage]
class InfoPage extends _i7.PageRouteInfo<InfoPageArgs> {
  InfoPage({
    _i8.Key? key,
    required int index,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          InfoPage.name,
          args: InfoPageArgs(
            key: key,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'InfoPage';

  static const _i7.PageInfo<InfoPageArgs> page =
      _i7.PageInfo<InfoPageArgs>(name);
}

class InfoPageArgs {
  const InfoPageArgs({
    this.key,
    required this.index,
  });

  final _i8.Key? key;

  final int index;

  @override
  String toString() {
    return 'InfoPageArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i4.PaymentPage]
class PaymentPage extends _i7.PageRouteInfo<PaymentPageArgs> {
  PaymentPage({
    required dynamic mode,
    required dynamic payDetails,
    required dynamic responsehashKey,
    required dynamic responseDecryptionKey,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          PaymentPage.name,
          args: PaymentPageArgs(
            mode: mode,
            payDetails: payDetails,
            responsehashKey: responsehashKey,
            responseDecryptionKey: responseDecryptionKey,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentPage';

  static const _i7.PageInfo<PaymentPageArgs> page =
      _i7.PageInfo<PaymentPageArgs>(name);
}

class PaymentPageArgs {
  const PaymentPageArgs({
    required this.mode,
    required this.payDetails,
    required this.responsehashKey,
    required this.responseDecryptionKey,
    this.key,
  });

  final dynamic mode;

  final dynamic payDetails;

  final dynamic responsehashKey;

  final dynamic responseDecryptionKey;

  final _i8.Key? key;

  @override
  String toString() {
    return 'PaymentPageArgs{mode: $mode, payDetails: $payDetails, responsehashKey: $responsehashKey, responseDecryptionKey: $responseDecryptionKey, key: $key}';
  }
}

/// generated route for
/// [_i5.SearchPage]
class SearchPage extends _i7.PageRouteInfo<SearchPageArgs> {
  SearchPage({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SearchPage.name,
          args: SearchPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SearchPage';

  static const _i7.PageInfo<SearchPageArgs> page =
      _i7.PageInfo<SearchPageArgs>(name);
}

class SearchPageArgs {
  const SearchPageArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'SearchPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.SuccessPage]
class SuccessPage extends _i7.PageRouteInfo<SuccessPageArgs> {
  SuccessPage({
    _i8.Key? key,
    required String transactionstatus,
    required String transactionid,
    required int trasactionstatus,
    required String paymentmethodname,
    required String totalamount,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SuccessPage.name,
          args: SuccessPageArgs(
            key: key,
            transactionstatus: transactionstatus,
            transactionid: transactionid,
            trasactionstatus: trasactionstatus,
            paymentmethodname: paymentmethodname,
            totalamount: totalamount,
          ),
          initialChildren: children,
        );

  static const String name = 'SuccessPage';

  static const _i7.PageInfo<SuccessPageArgs> page =
      _i7.PageInfo<SuccessPageArgs>(name);
}

class SuccessPageArgs {
  const SuccessPageArgs({
    this.key,
    required this.transactionstatus,
    required this.transactionid,
    required this.trasactionstatus,
    required this.paymentmethodname,
    required this.totalamount,
  });

  final _i8.Key? key;

  final String transactionstatus;

  final String transactionid;

  final int trasactionstatus;

  final String paymentmethodname;

  final String totalamount;

  @override
  String toString() {
    return 'SuccessPageArgs{key: $key, transactionstatus: $transactionstatus, transactionid: $transactionid, trasactionstatus: $trasactionstatus, paymentmethodname: $paymentmethodname, totalamount: $totalamount}';
  }
}
