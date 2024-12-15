import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_nasa_apod/src/core/theme/app_themes.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/apod_module.dart';
import 'package:get_it/get_it.dart';

import 'features/apod/presentation/bloc/apod/apod_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      modules: [
        ApodModule(),
      ],
      builder: (context, routes, flutterGetItNavObserver) {
        return BlocProvider(
          create: (context) => GetIt.instance<ApodBloc>(),
          child: MaterialApp(
            title: 'Nasa Apod',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            routes: routes,
            navigatorObservers: [
              flutterGetItNavObserver,
            ],
          ),
        );
      },
    );
  }
}
