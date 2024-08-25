import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/navigation/bottom_navigation.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: $constants.navigation.bottomNavigationScreens().length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        controller.animateTo(state.pageIndex);
      },
      builder: (context, state) {
        return Scaffold(
          appBar:
              $constants.navigation.appbars(context).elementAt(state.pageIndex),
          body: TabBarView(
            controller: controller,
            key: const ValueKey('acam'),
            physics: const NeverScrollableScrollPhysics(),
            children: $constants.navigation.bottomNavigationScreens(),
          ),
          bottomNavigationBar: BottomNavigation(
            destinations: $constants.navigation.bottomNavigationItems(context),
            currentPageIndex: state.pageIndex,
          ),
        );
      },
    );
  }
}
