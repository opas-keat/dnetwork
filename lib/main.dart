import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'app/shared/constant.dart';
import 'app/shared/page_not_found.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      title: "d-network",
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('th', 'TH'),
      ],
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', 'US'), // English
      //   Locale('th', 'TH'), // Thai
      // ],
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: "/not-found",
        page: () => const PageNotFound(),
        transition: Transition.noTransition,
      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        drawerTheme: const DrawerThemeData(
          scrimColor: Colors.transparent,
          elevation: 0.5,
          backgroundColor: canvasColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(defaultPadding),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.blue),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultPadding / 2),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultPadding / 2),
            borderSide: const BorderSide(color: Colors.black54, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultPadding / 2),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          fillColor: Colors.white.withOpacity(.5),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blue,
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: canvasColor,
          surfaceTintColor: Colors.transparent,
          elevation: 5,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.blue,
        ),
        canvasColor: canvasColor,
        scrollbarTheme: ScrollbarThemeData(
          trackVisibility: MaterialStateProperty.all(false),
          thumbVisibility: MaterialStateProperty.all(true),
          thumbColor: MaterialStateProperty.all<Color>(Colors.black26),
        ),
        textTheme: GoogleFonts.sarabunTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.black87),
      ),
    );
  }
}
