import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/commons.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/uicons.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        actions: [
          IconButton(
            onPressed: () => di<UserCubit>().logout(),
            icon: Icon(UIcons.boldRounded.exit),
            iconSize: 16,
          ),
        ],
        title: Text(
          context.router.topRoute.title(context),
          style: context.textTheme.headlineMedium?.bold,
        ),
      ),
      body: const Placeholder(),
    );
  }
}
