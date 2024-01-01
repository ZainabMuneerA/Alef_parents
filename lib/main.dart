// import 'package:alef_parents/views/searchPage.dart';
import 'dart:io';

import 'package:alef_parents/Features/Schedule_page/presentation/page/SchedulePage.dart';
import 'package:alef_parents/Features/User_Profile/presentation/bloc/student_evaluation/student_evaluation_bloc.dart';
import 'package:alef_parents/Features/User_Profile/presentation/pages/SettingsPage.dart';
import 'package:alef_parents/Features/User_Profile/presentation/pages/about_us.dart';
import 'package:alef_parents/Features/User_Profile/presentation/pages/contact_us.dart';
import 'package:alef_parents/Features/User_Profile/presentation/widgets/student_evaluation_report.dart';
import 'package:alef_parents/Features/attendance/presentation/pages/attendance_report.dart';
import 'package:alef_parents/Features/enroll_student/presentation/pages/EnrollStudent.dart';
import 'package:alef_parents/Features/enroll_student/presentation/widgets/navigation_form.dart';
import 'package:alef_parents/Features/events/presentation/pages/student_calendar_page.dart';
import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/search/search_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/pages/PreschoolPage.dart';
import 'package:alef_parents/Features/notification/presentation/pages/NotificationPage.dart';
import 'package:alef_parents/Features/payment/presentation/bloc/fees/fees_bloc.dart';
import 'package:alef_parents/Features/payment/presentation/pages/payment_details_page.dart';
import 'package:alef_parents/Features/payment/presentation/pages/payment_page.dart';
import 'package:alef_parents/firebase_options.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:alef_parents/testPayment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/Login/presentation/pages/LoginPage.dart';

import 'Features/User_Profile/presentation/pages/UserProfile.dart';
import 'Features/find_preschool/presentation/pages/HomePage.dart';
import 'Features/find_preschool/presentation/pages/searchPage.dart';

import 'Features/payment/presentation/pages/receipt_page.dart';
import 'Features/register/presentation/pages/RegisterPage.dart';
import 'core/app_theme.dart';
import 'core/shared/Navigation/presentation/widget/AppNavigationBar.dart';
import 'framework/services/notifications/notifications.dart';
import 'generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/.env';
// import 'package:dcdg/dcdg.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = stripePublicKey;
  await Stripe.instance.applySettings();
  if (Platform.isAndroid) {
    await Notifications().initiNorification(null);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Locale> savedLocale;
  late String? userEmail;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    savedLocale = getLocale();
    userEmail = await UserPreferences.getEmail();

    // Ensure that the state is updated after the asynchronous operations
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Locale>(
      future: savedLocale,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return loading or splash screen while waiting for the locale to be fetched.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle the error
          return Text('Error: ${snapshot.error}');
        } else {
          // Set the locale once it's fetched
          return MaterialApp(
            locale: snapshot.data,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'ALEF',

            //! routes
            initialRoute: '/',
            onGenerateRoute: (settings) {
              if (settings.name == '/login') {
                return MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                );
              }
              if (settings.name == '/notification') {
                return MaterialPageRoute(
                  builder: (context) => NotificationsPage(),
                );
              }
              if (settings.name == '/register') {
                return MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                );
              }
              if (settings.name == '/settings') {
                return MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                );
              }
              if (settings.name == '/home') {
                return MaterialPageRoute(
                  builder: (context) => const MyApp(),
                );
              }
              if (settings.name == '/preschool-profile') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null && args.containsKey('preschoolId')) {
                  return MaterialPageRoute(
                    builder: (context) => PreschoolProfile(
                      preschoolId: args['preschoolId'],
                    ),
                  );
                }
              }
              if (settings.name == '/enroll') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null &&
                    args.containsKey('preschoolId') &&
                    args.containsKey('preschoolName')) {
                  return MaterialPageRoute(
                    builder: (context) => EnrollStudent(
                      preschoolId: args['preschoolId'],
                      preschoolName: args['preschoolName'],
                    ),
                  );
                }
              }
              if (settings.name == '/schedule') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null &&
                    args.containsKey('preschoolId') &&
                    args.containsKey('applicationId') &&
                    args.containsKey('preschoolName')) {
                  return MaterialPageRoute(
                    builder: (context) => SchedulePage(
                      preschoolId: args['preschoolId'],
                      applicationId: args['applicationId'],
                      preschoolName: args['preschoolName'],
                    ),
                  );
                }
              }
              if (settings.name == '/user-profile') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null && args.containsKey('userId')) {
                  return MaterialPageRoute(
                    builder: (context) => UserProfile(
                      userId: args['userId'],
                    ),
                  );
                }
              }

              if (settings.name == '/about-us') {
                return MaterialPageRoute(
                  builder: (context) => AboutUsPage(),
                );
              }
              if (settings.name == '/contact-us') {
                return MaterialPageRoute(
                  builder: (context) => ContactUsPage(),
                );
              }
          
                     if (settings.name == '/student-calendar') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null && args.containsKey('classId')) {
                  return MaterialPageRoute(
                    builder: (context) => StudentCalendarPage(
                      classId: args['classId'],
                    ),
                  );
                }
              }

              if (settings.name == '/payment-details') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null && args.containsKey('studentId')) {
                  return MaterialPageRoute(
                    builder: (context) => PaymentDetailsPage(
                      studentId: args['studentId'],
                    ),
                  );
                }
              }


              if (settings.name == '/attendance-report') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null && args.containsKey('studentId')) {
                  return MaterialPageRoute(
                    builder: (context) => AttendancePage(
                      studentId: args['studentId'],
                    ),
                  );
                }
              }


              if (settings.name == '/student-report') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null && args.containsKey('studentId')) {
                  return MaterialPageRoute(
                    builder: (context) => StudentEvaluationPage(
                      studentId: args['studentId'],
                    ),
                  );
                }
              }
              if (settings.name == '/payment-page') {
                final Map<String, dynamic>? args =
                    settings.arguments as Map<String, dynamic>?;

                if (args != null &&
                    args.containsKey('dueAmount') &&
                    args.containsKey('paymentId')) {
                  return MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      dueAmount: args['dueAmount'],
                      paymentId: args['paymentId'],
                    ),
                  );
                }
              }
              if (userEmail == null) {
                return MaterialPageRoute(
                  builder: (context) => LoginPage(),
                );
              } else {
                return MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                );
              }
            },
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int? page;
  final String? searchString;
  MyHomePage({this.page, this.searchString});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  late List<Widget> _pages;
  int? userId; // Make userId nullable

  @override
  void initState() {
    super.initState();

    // Initialize pages with a placeholder
    _pages = [
      HomePage(),
      // SearchPage(searchQuery: widget.searchString),
      SchedulePage(preschoolId: 1, applicationId: 69, preschoolName: 'Alrayaheen'),
      Container(), // Placeholder widget

   
      // Add the remaining pages here
    ];

    if (widget.page != null) {
      _selectedIndex = widget.page!;
    }

    // Load userId and update the state
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    int? userIdLoaded = await UserPreferences.getUserId();
    setState(() {
      userId = userIdLoaded;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PreschoolBloc>()..add(getAllPreschoolEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<SearchBloc>()
            ..add(GetPreschoolByNameEvent(name: widget.searchString)),
        ),
      ],
      child: Scaffold(
        body: _buildPage(_selectedIndex),
        bottomNavigationBar: AppNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    // Check if userId is available before displaying UserProfile
    if (userId != null && index == 2) {
      _pages[2] = UserProfile(userId: userId!);
    } else if (userId == null && index == 2) {
      _pages[2] = LoginPage();
    }

    return _pages[index];
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

Future<void> setLocale(String languageCode) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', languageCode);
}

Future<Locale> getLocale() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('languageCode') ?? 'en';
  return Locale(languageCode);
}

class PdfViewerPage extends StatelessWidget {
  final String studentId;

  const PdfViewerPage({Key? key, required this.studentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentEvaluationBloc, StudentEvaluationState>(
      builder: (context, state) {
        if (state is LoadedEvaluationStudentState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('PDF Viewer'),
            ),
            body: PDFView(
              pdfData: state.pdf,
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('PDF Viewer'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
