import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:feature_user/presentation/cubits/user.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '_core/_i18n/translations.g.dart';
import '_core/super/super.dart';
import '_core/translations/translations_cubit.dart';
import 'router/router.dart';

class FeaturesApp extends StatefulWidget {
  FeaturesApp({super.key});

  @override
  State<FeaturesApp> createState() => _FeaturesAppState();
}

class _FeaturesAppState extends State<FeaturesApp> {
  final _featuresRouter = FeaturesRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => $.get<NetworkCubit>()),
        BlocProvider(create: (_) => $.get<TranslationsCubit>()),
        BlocProvider(create: (_) => $.get<ThemeCubit>()),
        BlocProvider(create: (_) => $.get<UserCubit>()),
      ],
      child: BlocListener<NetworkCubit, NetworkState>(
        listener: (_, state) {
          if (state == NetworkState.connected) {
            $.alert.popDialog();
          } else if (state == NetworkState.disconnected) {
            $.alert.showSheet(
              builder: (_) => const SizedBox(
                height: 50,
                child: Center(
                  child: Text('Connected'),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<TranslationsCubit, Locale>(
          builder: (_, locale) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (_, state) {
                return MaterialApp.router(
                  title: 'Flutter Advanced Boilerplate',
                  themeMode: state.theme.mode,
                  theme: state.theme.data,
                  locale: locale,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                  routerConfig: _featuresRouter.config(
                    navigatorObservers: () => [
                      $.get<ILogger>().routerTalker,
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
