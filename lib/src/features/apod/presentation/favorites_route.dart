import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/favorites_page.dart';

class FavoritesRoute extends FlutterGetItModulePageRouter {
  const FavoritesRoute({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  WidgetBuilder get view => (_) => const FavoritesPage();
}
