// import 'package:alef_parents/views/searchPage.dart';
import 'package:alef_parents/Features/enroll_student/presentation/pages/EnrollStudent.dart';
import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/pages/PreschoolPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'Features/Login/presentation/pages/LoginPage.dart';
import 'Features/Schedule_page/presentation/page/SchedulePage.dart';
import 'Features/User_Profile/presentation/pages/UserProfile.dart';
import 'Features/find_preschool/presentation/pages/HomePage.dart';
import 'Features/find_preschool/presentation/pages/searchPage.dart';

import 'core/app_theme.dart';
import 'core/shared/Navigation/presentation/widget/AppNavigationBar.dart';
import 'generated/l10n.dart';
import 'package:intl/intl.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'ALEF',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int? page;
  MyHomePage({this.page});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    UserProfile(),
     EnrollStudent(),
    // Add the remaining pages here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
    // checkTranslations();
  }

  @override
  void initState() {
    super.initState();
    if (widget.page != null) {
      _selectedIndex = widget.page!;
    }
  }

  @override
Widget build(BuildContext context) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => di.sl<PreschoolBloc>()..add(getAllPreschoolEvent()))
    ],
    child: Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    ),
  );
}
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
