// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../data.dart';
import 'package:aksan_mobile/src/screens/other_pages.dart';
import 'package:aksan_mobile/src/web_view/web_view_state.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../routing.dart';
import 'fade_transition_page.dart';
import 'scaffold.dart';

/// Displays the contents of the body of [KaldeScaffold]
class KaldeScaffoldBody extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const KaldeScaffoldBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentRoute = RouteStateScope.of(context).route;

    WebViewState view = WebViewStateScope.of(context);

    final routeState = RouteStateScope.of(context);

    // A nested Router isn't necessary because the back button behavior doesn't
    // need to be customized.
    // return WebViewWidget(controller: WebViewStateScope.of(context).controller);
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, dynamic result) => route.didPop(result),
      pages: [
        if (currentRoute.pathTemplate == '/diger')
          const FadeTransitionPage<void>(
            key: ValueKey('Other Pages'),
            child: OtherPagesScreen(),
          )
        else if (currentRoute.pathTemplate.startsWith(RegExp(
            r'/(anaSayfa|cariKartlar|satisGorusmeleri|tahsilatlar|page|cikis)')))
          FadeTransitionPage<void>(
            key: const ValueKey('Web View'),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(pages.getPage(routeState)?.title ?? 'Ana Sayfa'),
              ),
              body: WebViewWidget(
                controller: view.controller,
              ),
            ),
          )

        // Avoid building a Navigator with an empty `pages` list when the
        // RouteState is set to an unexpected path, such as /signin.
        //
        // Since RouteStateScope is an InheritedNotifier, any change to the
        // route will result in a call to this build method, even though this
        // widget isn't built when those routes are active.
        else
          FadeTransitionPage<void>(
            key: const ValueKey('empty'),
            child: Container(),
          ),
      ],
    );
  }
}
