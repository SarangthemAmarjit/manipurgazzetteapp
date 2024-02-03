// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:atompaymentdemo/pages/billingpage.dart' as _i1;
import 'package:atompaymentdemo/pages/Dashboard.dart' as _i2;
import 'package:atompaymentdemo/pages/homepage.dart' as _i3;
import 'package:atompaymentdemo/pages/PaymentPage.dart' as _i4;
import 'package:atompaymentdemo/pages/searchpage.dart' as _i5;
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    BillingPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child:  _i1.BillingPage(),
      );
    },
    DashBoardPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashBoardPage(),
      );
    },
    HomePage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    PaymentPage.name: (routeData) {
      final args = routeData.argsAs<PaymentPageArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PaymentPage(
          args.url,
          args.resHashKey,
          key: args.key,
        ),
      );
    },
    SearchPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SearchPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BillingPage]
class BillingPage extends _i6.PageRouteInfo<void> {
  const BillingPage({List<_i6.PageRouteInfo>? children})
      : super(
          BillingPage.name,
          initialChildren: children,
        );

  static const String name = 'BillingPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DashBoardPage]
class DashBoardPage extends _i6.PageRouteInfo<void> {
  const DashBoardPage({List<_i6.PageRouteInfo>? children})
      : super(
          DashBoardPage.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomePage extends _i6.PageRouteInfo<void> {
  const HomePage({List<_i6.PageRouteInfo>? children})
      : super(
          HomePage.name,
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PaymentPage]
class PaymentPage extends _i6.PageRouteInfo<PaymentPageArgs> {
  PaymentPage({
    required dynamic url,
    required dynamic resHashKey,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          PaymentPage.name,
          args: PaymentPageArgs(
            url: url,
            resHashKey: resHashKey,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentPage';

  static const _i6.PageInfo<PaymentPageArgs> page =
      _i6.PageInfo<PaymentPageArgs>(name);
}

class PaymentPageArgs {
  const PaymentPageArgs({
    required this.url,
    required this.resHashKey,
    this.key,
  });

  final dynamic url;

  final dynamic resHashKey;

  final _i7.Key? key;

  @override
  String toString() {
    return 'PaymentPageArgs{url: $url, resHashKey: $resHashKey, key: $key}';
  }
}

/// generated route for
/// [_i5.SearchPage]
class SearchPage extends _i6.PageRouteInfo<void> {
  const SearchPage({List<_i6.PageRouteInfo>? children})
      : super(
          SearchPage.name,
          initialChildren: children,
        );

  static const String name = 'SearchPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
