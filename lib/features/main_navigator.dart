import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/navigation/bottom_navigation.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/utils/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            appBar: Navigation.appbars(context).elementAt(state.pageIndex),
            body: Stack(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Navigation.bottomNavigationScreens(context).elementAt(state.pageIndex),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigation(
              destinations: Navigation.bottomNavigationItems(context),
              currentPageIndex: state.pageIndex,
            ),
          );
        },
      ),
    );
  }
}
