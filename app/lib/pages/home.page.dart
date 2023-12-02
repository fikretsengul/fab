import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeRouter extends AutoRouter {
  const HomeRouter({super.key});
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(),
    );
  }
}
