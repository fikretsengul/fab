// ignore_for_file: max_lines_for_file, max_lines_for_function
import 'dart:async';

import 'package:deps/packages/easy_refresh.dart';
import 'package:deps/packages/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

class NestedScrollViewPage extends StatefulWidget {
  const NestedScrollViewPage({super.key});

  @override
  NestedScrollViewPageState createState() {
    return NestedScrollViewPageState();
  }
}

class NestedScrollViewPageState extends State<NestedScrollViewPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  int _listCount = 20;
  int _gridCount = 20;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          labelColor: themeData.colorScheme.primary,
          indicatorColor: themeData.colorScheme.primary,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
          tabs: const <Widget>[
            Tab(
              text: 'List',
            ),
            Tab(
              text: 'Grid',
            ),
          ],
        ),
        Expanded(
          child: IndexedStack(
            index: _tabIndex,
            children: <Widget>[
              ExtendedVisibilityDetector(
                uniqueKey: const Key('Tab0'),
                child: EasyRefresh(
                  header: const ClassicHeader(
                    dragText: 'Pull to refresh',
                    armedText: 'Release ready',
                    readyText: 'Refreshing...',
                    processingText: 'Refreshing...',
                    processedText: 'Succeeded',
                    noMoreText: 'No more',
                    failedText: 'Failed',
                    messageText: 'Last updated at %T',
                    safeArea: false,
                  ),
                  footer: const ClassicFooter(
                    position: IndicatorPosition.locator,
                    dragText: 'Pull to load',
                    armedText: 'Release ready',
                    readyText: 'Loading...',
                    processingText: 'Loading...',
                    processedText: 'Succeeded',
                    noMoreText: 'No more',
                    failedText: 'Failed',
                    messageText: 'Last updated at %T',
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, __) {
                            return const SizedBox(
                              height: 70,
                              child: Placeholder(),
                            );
                          },
                          childCount: _listCount,
                        ),
                      ),
                      const FooterLocator.sliver(),
                    ],
                  ),
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          _listCount = 20;
                        });
                      }
                    });
                  },
                  onLoad: () async {
                    await Future.delayed(const Duration(seconds: 2), () {
                      if (mounted && _listCount < 30) {
                        setState(() {
                          _listCount += 10;
                        });
                      }
                    });
                  },
                ),
              ),
              ExtendedVisibilityDetector(
                uniqueKey: const Key('Tab1'),
                child: EasyRefresh(
                  header: const ClassicHeader(
                    dragText: 'Pull to refresh',
                    armedText: 'Release ready',
                    readyText: 'Refreshing...',
                    processingText: 'Refreshing...',
                    processedText: 'Succeeded',
                    noMoreText: 'No more',
                    failedText: 'Failed',
                    messageText: 'Last updated at %T',
                    safeArea: false,
                  ),
                  footer: const ClassicFooter(
                    position: IndicatorPosition.locator,
                    dragText: 'Pull to load',
                    armedText: 'Release ready',
                    readyText: 'Loading...',
                    processingText: 'Loading...',
                    processedText: 'Succeeded',
                    noMoreText: 'No more',
                    failedText: 'Failed',
                    messageText: 'Last updated at %T',
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (_, __) {
                            return const SizedBox(
                              height: 70,
                              child: Placeholder(),
                            );
                          },
                          childCount: _gridCount,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 6 / 7,
                        ),
                      ),
                      const FooterLocator.sliver(),
                    ],
                  ),
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          _gridCount = 30;
                        });
                      }
                    });
                  },
                  onLoad: () async {
                    await Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          _gridCount += 10;
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
