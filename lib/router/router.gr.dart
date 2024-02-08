// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:atompaymentdemo/pages/billingpage.dart' as _i1;
import 'package:atompaymentdemo/pages/Dashboard.dart' as _i2;
import 'package:atompaymentdemo/pages/paymentpage.dart' as _i3;
import 'package:atompaymentdemo/pages/searchpage.dart' as _i4;
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    BillingPage.name: (routeData) {
      final args = routeData.argsAs<BillingPageArgs>(
          orElse: () => const BillingPageArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BillingPage(key: args.key),
      );
    },
    DashBoardPage.name: (routeData) {
      final args = routeData.argsAs<DashBoardPageArgs>(
          orElse: () => const DashBoardPageArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DashBoardPage(key: args.key),
      );
    },
    PaymentPage.name: (routeData) {
      final args = routeData.argsAs<PaymentPageArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PaymentPage(
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
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.SearchPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.BillingPage]
class BillingPage extends _i5.PageRouteInfo<BillingPageArgs> {
  BillingPage({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          BillingPage.name,
          args: BillingPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BillingPage';

  static const _i5.PageInfo<BillingPageArgs> page =
      _i5.PageInfo<BillingPageArgs>(name);
}

class BillingPageArgs {
  const BillingPageArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'BillingPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.DashBoardPage]
class DashBoardPage extends _i5.PageRouteInfo<DashBoardPageArgs> {
  DashBoardPage({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          DashBoardPage.name,
          args: DashBoardPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DashBoardPage';

  static const _i5.PageInfo<DashBoardPageArgs> page =
      _i5.PageInfo<DashBoardPageArgs>(name);
}

class DashBoardPageArgs {
  const DashBoardPageArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'DashBoardPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.PaymentPage]
class PaymentPage extends _i5.PageRouteInfo<PaymentPageArgs> {
  PaymentPage({
    required dynamic mode,
    required dynamic payDetails,
    required dynamic responsehashKey,
    required dynamic responseDecryptionKey,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
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

  static const _i5.PageInfo<PaymentPageArgs> page =
      _i5.PageInfo<PaymentPageArgs>(name);
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

  final _i6.Key? key;

  @override
  String toString() {
    return 'PaymentPageArgs{mode: $mode, payDetails: $payDetails, responsehashKey: $responsehashKey, responseDecryptionKey: $responseDecryptionKey, key: $key}';
  }
}

/// generated route for
/// [_i4.SearchPage]
class SearchPage extends _i5.PageRouteInfo<SearchPageArgs> {
  SearchPage({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          SearchPage.name,
          args: SearchPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SearchPage';

  static const _i5.PageInfo<SearchPageArgs> page =
      _i5.PageInfo<SearchPageArgs>(name);
}

class SearchPageArgs {
  const SearchPageArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'SearchPageArgs{key: $key}';
  }
}
