// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class KaldeScaffold extends StatelessWidget {
  const KaldeScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: const KaldeScaffoldBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/anaSayfa');
          if (idx == 1) routeState.go('/cariKartlar');
          if (idx == 2) routeState.go('/satisGorusmeleri');
          if (idx == 3) routeState.go('/tahsilatlar');
          if (idx == 4) routeState.go('/diger');
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.copy_outlined),
            icon: Icon(Icons.copy_outlined),
            label: 'Cari Kartlar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people),
            icon: Icon(Icons.people_outlined),
            label: 'Görüşmeler',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.money),
            icon: Icon(Icons.money_outlined),
            label: 'Tahsilatlar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu),
            icon: Icon(Icons.menu),
            label: 'Diğer',
          ),
        ],
        // backgroundColor: const Color(0xFF272B35),
        // surfaceTintColor: Colors.transparent,
        indicatorShape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate == '/anaSayfa') return 0;
    if (pathTemplate == '/cikis') return 0;
    if (pathTemplate == '/cariKartlar') return 1;
    if (pathTemplate == '/satisGorusmeleri') return 2;
    if (pathTemplate == '/tahsilatlar') return 3;
    if (pathTemplate == '/diger') return 4;
    if (pathTemplate.startsWith('/page')) return 4;
    return 0;
  }
}
