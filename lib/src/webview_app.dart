import 'package:aksan_mobile/common/meta_data.dart';
import 'package:aksan_mobile/common/theme.dart';
import 'package:aksan_mobile/src/routing/delegate.dart';
import 'package:aksan_mobile/src/routing/parser.dart';
import 'package:aksan_mobile/src/routing/route_state.dart';
import 'package:aksan_mobile/src/screens/navigator.dart';
import 'package:aksan_mobile/src/web_view/web_view_state.dart';
import 'package:flutter/material.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewState _view;
  final _navigatorKey = GlobalKey<NavigatorState>();

  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  int currentPageIndex = 0;

  @override
  void initState() {
    /// Configure the parser with all of the app's allowed path templates.
    _routeParser = TemplateRouteParser(
      allowedPaths: [
        '/anaSayfa',
        '/cariKartlar',
        '/satisGorusmeleri',
        '/tahsilatlar',
        '/diger',
        '/cikis',
        '/page/:pageId',
      ],
      initialRoute: '/anaSayfa',
    );

    _routeState = RouteState(_routeParser);

    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => KaldeNavigator(
        navigatorKey: _navigatorKey,
      ),
    );

    // Listen for when the user logs out and display the signin screen.
    // _auth.addListener(_handleAuthStateChanged);

    _view = WebViewState('https://app.kaldesmart.com/');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RouteStateScope(
      notifier: _routeState,
      child: WebViewStateScope(
        notifier: _view,
        child: MaterialApp.router(
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeParser,
          title: appTitle,
          theme: appTheme,
          // darkTheme: appDarkTheme,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _auth.removeListener(_handleAuthStateChanged);
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
