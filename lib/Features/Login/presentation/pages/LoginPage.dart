import 'package:alef_parents/Features/Login/presentation/Bloc/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/shared/Navigation/presentation/widget/AppNavigationBar.dart';
import '../../../../core/shared/Navigation/presentation/widget/ArchWidget.dart';
import '../widget/EmailInputFb2.dart';
import '../widget/PasswordInputFB2.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _login() {
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     // Perform login logic here, e.g., validate credentials, make API calls, etc.

//     // For this example, let's just print the entered username and password
//     print('Username: $email');
//     print('Password: $password');

//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginBloc>(
//           create: (_) => di.sl<LoginBloc>()..add(LogUserEvent("test", "123")),
//         ),
//       ],
//       child: Scaffold(
//         body: Stack(
//           children: [
//             ClipPath(
//               clipper: ArchClipper(),
//               child: Container(
//                 color: primaryColor,
//                 height: 350,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Login',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   EmailInputFb2(inputController: _emailController),
//                   SizedBox(height: 16.0),
//                   PasswordInputFb2(inputController: _passwordController),
//                   SizedBox(height: 24.0),
//                   Text.rich(
//                     TextSpan(
//                       text: "Don't have an account? ",
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: 'Register now',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 24.0),
//                   SizedBox(
//                     width: 174,
//                     height: 61,
//                     child: ElevatedButton(
//                       onPressed: _login,
//                       child: const Text(
//                         'Login',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       style: ButtonStyle(
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                         ),
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(primaryColor),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Use dependency injection to get the LoginBloc
    LoginBloc loginBloc = di.sl<LoginBloc>();

    // Dispatch the login event to the existing bloc
    loginBloc.add(LogUserEvent(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => di.sl<LoginBloc>(),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            ClipPath(
              clipper: ArchClipper(),
              child: Container(
                color: primaryColor,
                height: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  EmailInputFb2(inputController: _emailController),
                  SizedBox(height: 16.0),
                  PasswordInputFb2(inputController: _passwordController),
                  SizedBox(height: 24.0),
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      // Handle different states and perform actions accordingly
                      if (state is LoadingLoginState) {
                        // Show loading indicator
                        return CircularProgressIndicator();
                      } else if (state is LoadedLoginState) {
                        // Do something on successful login
                        // For example, navigate to the next screen
                        print("logedddd in");
                      } else if (state is ErrorLoginState) {
                        // Handle login failure, show error message, etc.
                        return Text('Login failed: ${state.message}');
                      }

                     
                      return SizedBox(
                        width: 174,
                        height: 61,
                        child: ElevatedButton(
                          onPressed: _login,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
