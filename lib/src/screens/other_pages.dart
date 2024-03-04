// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../data.dart';
// import 'package:aksan_mobile/src/web_view/web_view_state.dart';
import 'package:aksan_mobile/src/widgets/page_list.dart';
import 'package:flutter/material.dart';

import '../routing.dart';

class OtherPagesScreen extends StatefulWidget {
  const OtherPagesScreen({
    super.key,
  });

  @override
  State<OtherPagesScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<OtherPagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Diğer Sayfalar'),
          actions: [
            TextButton.icon(
                style: const ButtonStyle(alignment: Alignment.centerLeft),
                onPressed: _handleLogOut,
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Çıkış Yap')),
          ],
          elevation: 8,
          bottom: TabBar(
            onTap: (idx) {
              _tabController.index = idx;
            },
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Raporlar',
                icon: Icon(Icons.add_chart_rounded),
              ),
              Tab(
                text: 'Sistem Yönetimi',
                icon: Icon(Icons.settings),
              ),
              Tab(
                text: 'Tanımlamalar',
                icon: Icon(Icons.data_object),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // PageView(children: const [Text('sayfa 1')]),
            // PageView(children: const [Text('sayfa 3')]),
            PageList(
              pages: pages.raporlar,
              onTap: _handlePageTapped,
            ),
            PageList(
              pages: pages.sistemYonetimi,
              onTap: _handlePageTapped,
            ),
            // PageView(children: const [Text('sayfa 2')]),

            PageList(
              pages: pages.tanimlamalar,
              onTap: _handlePageTapped,
            ),
          ],
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);
  // WebViewState get _view => WebViewStateScope.of(context);

  void _handleLogOut() {
    _routeState.go('/cikis'); // Prints after 1 second.
    // _view.redirect('/Login/LogOut');

    // Future.delayed(const Duration(milliseconds: 100), () {
    //   _routeState.go('/anaSayfa'); // Prints after 1 second.
    // });
  }

  void _handlePageTapped(PageURL page) {
    _routeState.go('/page/${page.id}');
    // _view.redirect('/page/${page.id}');
  }

  void _handleTabIndexChanged() {}
}
