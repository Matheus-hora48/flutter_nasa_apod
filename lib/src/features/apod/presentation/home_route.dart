import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/home_page.dart';

class HomeRoute extends FlutterGetItModulePageRouter {
  const HomeRoute({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  WidgetBuilder get view => (_) => const HomePage();
}
