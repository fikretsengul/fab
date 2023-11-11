import 'package:deps/core/routing/page.dart';
import 'package:deps/features/auth.dart';

import '../pages/test_layout_page.dart';
import '../pages/test_page_a.dart';
import '../pages/test_page_b.dart';

enum Pages {
  login('login', '/login'),
  testA('testA', '/testa'),
  testB('testB', '/testb');

  const Pages(this.name, this.path);

  final String name;
  final String path;
}

final List<PageDelegate> pages = [
  LayoutPage(
    builder: (_, child) => TestLayoutPage(child),
    childPages: [
      SinglePage(
        name: Pages.testA.name,
        path: Pages.testA.path,
        builder: (_) => const TestPageA(),
      ),
      SinglePage(
        name: Pages.testB.name,
        path: Pages.testB.path,
        builder: (_) => const TestPageB(),
      ),
    ],
  ),
  SinglePage(
    name: Pages.login.name,
    path: Pages.login.path,
    builder: (_) => const LoginScreen(),
  ),
];
