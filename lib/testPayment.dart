import 'package:alef_parents/Features/outstanding/presentation/bloc/bloc/outstanding_bloc.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPage extends StatelessWidget {
  final String title;

  const FormPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24),
            ),
            // Add your form widgets here
            // Example:
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter something...'),
            ),
          ],
        ),
      ),
    );
  }
}