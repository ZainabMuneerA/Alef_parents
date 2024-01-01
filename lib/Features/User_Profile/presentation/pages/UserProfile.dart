import 'package:alef_parents/Features/User_Profile/presentation/bloc/student/student_bloc.dart';
import 'package:alef_parents/Features/enroll_student/presentation/bloc/Application/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/shared/Navigation/presentation/widget/ArchWidget.dart';
import '../../../../core/widget/profilePic.dart';
import 'package:alef_parents/injection_container.dart' as di;

import '../../../../framework/shared_prefrences/UserPreferences.dart';
import '../widgets/TapBar.dart';

class UserProfile extends StatefulWidget {
  final int userId;
  const UserProfile({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (_) => di.sl<ApplicationBloc>()
            ..add(GetApplicationEvent(id: widget.userId)),
        ),
        BlocProvider<StudentBloc>(
          create: (_) =>
              di.sl<StudentBloc>()..add(GetStudentEvent(userId: widget.userId)),
        ),
        
      ],
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  // Clip the background image using the ArchClipper widget
                  ClipPath(
                    clipper: ArchClipper(),
                    child: Container(
                      color: primaryColor,
                      // height: 350,
                    ),
                  ),

                  Positioned(
                    top: 30,
                    right: 16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ),

                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),
                          const ProfilePic(
                            isAssets: true,
                            assetImage: 'lib/assets/images/profile_holder.png',
                            imageUrl: null,
                          ),
                          const SizedBox(height: 16),
                          FutureBuilder<String?>(
                            future: UserPreferences.getUsername(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // While the Future is still running, display a loading indicator or placeholder.
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // If an error occurred, display an error message.
                                return Text('Error: ${snapshot.error}');
                              } else {
                                // If the Future completed successfully, display the username.
                                return Text(
                                  snapshot.data ?? 
                                  'Unknown',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarAndTabViews(),
            ),
          ],
        ),
      ),
    );
  }
}
