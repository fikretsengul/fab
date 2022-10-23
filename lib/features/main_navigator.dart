import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/navigation/bottom_navigation.dart';
import 'package:flutter_advanced_boilerplate/theme/app_theme_creator.dart';
import 'package:flutter_advanced_boilerplate/utils/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _NavigatorState();
}

class _NavigatorState extends State<MainNavigator> {
  @override
  void initState() {
    super.initState();

    AdaptiveTheme.of(context).modeChangeNotifier.addListener(() {
      final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

      SystemChrome.setSystemUIOverlayStyle(
        getAppOverlayStyle(
          isDark: isDark,
          colorScheme: isDark
              ? AdaptiveTheme.of(context).darkTheme.colorScheme
              : AdaptiveTheme.of(context).lightTheme.colorScheme,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: Navigation.appbars.elementAt(state.pageIndex),
          body: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Navigation.bottomNavigationScreens.elementAt(state.pageIndex),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            destinations: Navigation.bottomNavigationItems,
            currentPageIndex: state.pageIndex,
          ),
        );
      },
    );
  }
}
