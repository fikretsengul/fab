import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/super_cupertino_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../router/router.gr.dart';

@RoutePage()
class HomeRouter extends AutoRouter {
  const HomeRouter({super.key});
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      backgroundColor: Colors.black,
      appBar: SuperAppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Home',
          style: TextStyle(
            inherit: false,
            fontFamily: FontFamily.visueltPro,
            fontSize: 24,
          ),
        ),
        largeTitle: SuperLargeTitle(
          largeTitle: 'Home',
          textStyle: const TextStyle(
            fontFamily: FontFamily.visueltPro,
            inherit: false,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.41,
          ),
        ),
        searchBar: SuperSearchBar(
          enabled: false,
        ),
        actions: CupertinoButton(
          onPressed: $.get<UserCubit>().logout,
          child: const Icon(CupertinoIcons.settings),
        ),
      ),
      body: [
        ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: 200,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return ListTile(
              title: Text('Item ${index + 1}'),
              onTap: () => $.navigator.push(FontsRoute()),
            );
          },
          separatorBuilder: (_, __) => Divider(
            color: CupertinoColors.systemGrey.withOpacity(0.35),
            height: 0,
          ),
        ),
/*         Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text($.tr.core.permissions.dialog.buttons.openSettings),
              ElevatedButton(
                onPressed: $.tr.setEN,
                child: const Text('EN'),
              ),
              ElevatedButton(
                onPressed: $.tr.setTR,
                child: const Text('TR'),
              ),
              ElevatedButton(
                onPressed: () => $.navigator.push(FontsRoute()),
                child: const Text('Go to super'),
              ),
              ElevatedButton(
                onPressed: () => $.debug($.get<UserCubit>().state),
                child: const Text('Log user'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await $.permissions.request(PermissionType.camera);
                },
                child: const Text('Open Image Picker'),
              ),
            ],
          ),
        ), */
      ],
    );
  }
}
