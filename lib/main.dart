// import 'package:alef_parents/views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'core/app_theme.dart';
import 'extra for now/views/searchPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'ALEF',
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            useCountryCode: false,
            fallbackFile: 'en',
            basePath: 'assets/i18n',
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
    checkTranslations();
  }

  void checkTranslations() async {
    Locale englishLocale = const Locale('en');
    await FlutterI18n.refresh(context, englishLocale);
    String enTranslation = FlutterI18n.translate(context, 'search_hint');

    Locale arabicLocale = const Locale('ar');
    await FlutterI18n.refresh(context, arabicLocale);
    String arTranslation = FlutterI18n.translate(context, 'search_hint');

    print('English Translation: $enTranslation');
    print('Arabic Translation: $arTranslation');
  }

  void _navigateToSearchPage(String searchQuery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: SearchPage(searchQuery: searchQuery),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              child: Column(
                children: [
                  SizedBox(height: 80),
                  MySearchBar(
                    onSearch: (value) {
                      print('Home Search query: $value');
                      _navigateToSearchPage(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}