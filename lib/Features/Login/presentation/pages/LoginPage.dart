import 'package:alef_parents/Features/Login/presentation/Bloc/bloc/login_bloc.dart';
import 'package:alef_parents/core/widget/reuseable_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/shared/Navigation/presentation/widget/AppNavigationBar.dart';
import '../../../../core/shared/Navigation/presentation/widget/ArchWidget.dart';
import '../../../../framework/services/auth/auth.dart';
import '../../../../generated/l10n.dart';
import '../widget/googleBtn.dart';

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
  String? loginError;
  Auth auth = Auth();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        String? errorMessage =
            await auth.signInWithEmailAndPassword(email, password);

        if (errorMessage != null) {
          setState(() {
            loginError = errorMessage;
          });
        } else {
          // Login successful, navigate to home page
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (error) {
        // Handle other errors
        print("Error during login: $error");
      }
    } else {
      setState(() {
        loginError = "Please fill in the required fields";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: ArchClipper(),
              child: Container(
                color: primaryColor,
                height: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 200, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).login,
                    style: const TextStyle(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (loginError != null && loginError!.isNotEmpty)
                    Text(loginError!,
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16.0,
                        )),
                  ReusableInputField(
                    inputController: _emailController,
                    label: S.of(context).email,
                  ),
                  const SizedBox(height: 16.0),
                  ReusableInputField(
                    inputController: _passwordController,
                    label: S.of(context).password,
                    isPassword: true,
                  ),
                  const SizedBox(height: 24.0),
                  Text.rich(
                    TextSpan(
                      text: S.of(context).no_account,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: S.of(context).register,
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/register');
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: 330,
                    height: 61,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                      ),
                      child: Text(
                        S.of(context).login,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // GoogleBtn(
                  //   onPressed: () {
                  //     auth.signInWithGoogle().then((userCredential) {
                  //       // Handle successful login here
                  //       // Navigate to the home page using the named route
                  //       Navigator.pushReplacementNamed(context, '/home');
                  //     }).catchError((error) {
                  //       // Handle errors if needed
                  //       print("Error during Google sign-in: $error");
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
