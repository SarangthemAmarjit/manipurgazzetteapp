import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        //HomeScreen is generated as HomeRoute because
        //of the replaceInRouteName property
        AutoRoute(
          initial: true,
          path: '/',
          page: DashBoardPage.page,
        ),
        AutoRoute(
          path: '/paymentpage',
          page: PaymentPage.page
        ),
             AutoRoute(
          path: '/successpage',
          page: SuccessPage.page
        ),

        AutoRoute(path: '/searchpage', page: SearchPage.page),
        AutoRoute(path: '/billingpage', page: BillingPage.page),
      ];
}
