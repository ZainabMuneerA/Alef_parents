import 'package:alef_parents/core/widget/reuseable_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/shared/Navigation/presentation/widget/ArchWidget.dart';
import 'package:alef_parents/injection_container.dart' as di;
import '../../../../generated/l10n.dart';
import '../Bloc/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? registerError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 void _register() async {
  String email = _emailController.text;
  String name = _nameController.text;
  String password = _passwordController.text;
  String confirmPassword = _confirmPasswordController.text;

  if (email.isEmpty && password.isEmpty && confirmPassword.isEmpty && name.isEmpty) {
    setState(() {
      registerError = 'Please fill all the fields';
    });
  } else if (password != confirmPassword) {
    setState(() {
      registerError = 'Passwords do not match';
    });
  } else {
    try {
      print("registering....");
      // Use dependency injection to get the RegisterBloc
      RegisterBloc registerBloc = di.sl<RegisterBloc>();

      // Dispatch the registration event to the existing bloc
       registerBloc.add(RegisterUserEvent(email, name, password));
       
          // Registration successful, navigate to home page
          Navigator.pushReplacementNamed(context, '/home');
     
    
    } catch (error) {
      // Handle other errors
      print("Error during register: $error");
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(create: (_) => di.sl<RegisterBloc>()),
      ],
      child: Scaffold(
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
              Positioned(
                top: 30,
                left: 16,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // Handle the back button press
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 200, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).register,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    if (registerError != null && registerError!.isNotEmpty)
                      Text(
                        registerError!,
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ReusableInputField(
                      inputController: _emailController,
                      label: S.of(context).email,
                    ),
                    ReusableInputField(
                      inputController: _nameController,
                      label: S.of(context).name,
                    ),
                    ReusableInputField(
                      inputController: _passwordController,
                      label: S.of(context).password,
                      isPassword: true,
                    ),
                    ReusableInputField(
                      inputController: _confirmPasswordController,
                      label: S.of(context).confirm_password,
                      isPassword: true,
                    ),
                    const SizedBox(height: 24.0),
                    Text.rich(
                      TextSpan(
                        text: S.of(context).yes_account,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).login,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/login');
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
                        onPressed: _register,
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
                          S.of(context).register,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
