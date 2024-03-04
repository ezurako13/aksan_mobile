// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:aksan_mobile/src/web_view/web_view_state.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/scaffold.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class KaldeNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const KaldeNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<KaldeNavigator> createState() => _KaldeNavigatorState();
}

class _KaldeNavigatorState extends State<KaldeNavigator> {
  // final _signInKey = const ValueKey('Sign in');
  final _scaffoldKey = const ValueKey('App scaffold');

  WebViewState get _view => WebViewStateScope.of(context);

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);

    PageURL? selectedPage = pages.getPage(routeState);
    if (selectedPage != null) {
      // If the page doesn't exist, display the 404 page.
      _view.redirect(selectedPage.url);
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, result) => route.didPop(result),
      pages: [
        // Display the app
        MaterialPage<void>(
          key: _scaffoldKey,
          child: const KaldeScaffold(),
        ),
      ],
    );
  }
}
