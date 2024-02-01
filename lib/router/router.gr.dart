// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:atompaymentdemo/pages/searchpage.dart' as _i4;
import 'package:atompaymentdemo/pages/Dashboard.dart' as _i1;
import 'package:atompaymentdemo/pages/homepage.dart' as _i2;
import 'package:atompaymentdemo/pages/PaymentPage.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    DashBoardPage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashBoardPage(),
      );
    },
    HomePage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    PaymentPage.name: (routeData) {
      final args = routeData.argsAs<PaymentPageArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PaymentPage(
          args.url,
          args.resHashKey,
          key: args.key,
        ),
      );
    },
    SearchPage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SearchPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DashBoardPage]
class DashBoardPage extends _i5.PageRouteInfo<void> {
  const DashBoardPage({List<_i5.PageRouteInfo>? children})
      : super(
          DashBoardPage.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardPage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomePage extends _i5.PageRouteInfo<void> {
  const HomePage({List<_i5.PageRouteInfo>? children})
      : super(
          HomePage.name,
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PaymentPage]
class PaymentPage extends _i5.PageRouteInfo<PaymentPageArgs> {
  PaymentPage({
    required dynamic url,
    required dynamic resHashKey,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
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

  static const _i5.PageInfo<PaymentPageArgs> page =
      _i5.PageInfo<PaymentPageArgs>(name);
}

class PaymentPageArgs {
  const PaymentPageArgs({
    required this.url,
    required this.resHashKey,
    this.key,
  });

  final dynamic url;

  final dynamic resHashKey;

  final _i6.Key? key;

  @override
  String toString() {
    return 'PaymentPageArgs{url: $url, resHashKey: $resHashKey, key: $key}';
  }
}

/// generated route for
/// [_i4.SearchPage]
class SearchPage extends _i5.PageRouteInfo<void> {
  const SearchPage({List<_i5.PageRouteInfo>? children})
      : super(
          SearchPage.name,
          initialChildren: children,
        );

  static const String name = 'SearchPage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
