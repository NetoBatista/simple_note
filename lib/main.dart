import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:simple_note/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [Locale("pt", "BR"), Locale("en", "US")],
      localeResolutionCallback: (locale, supportedLocale) {
        if (supportedLocale.contains(locale)) {
          return locale;
        }
        return const Locale("en", "US");
      },
      routerConfig: Modular.routerConfig,
    );
  }
}
