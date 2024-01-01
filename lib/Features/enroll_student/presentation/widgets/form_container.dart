// import 'package:alef_parents/core/app_theme.dart';
// import 'package:flutter/material.dart';

// class FormContainer extends StatefulWidget {
//   final List<Widget> formFields;
//   final String buttonText;
//   final Function() buttonOnPressed;
//   final bool isFirst;

//   FormContainer({
//     required this.formFields,
//     required this.buttonText,
//     required this.buttonOnPressed,
//     required this.isFirst,
//   });

//   @override
//   _FormContainerState createState() => _FormContainerState();
// }

// class _FormContainerState extends State<FormContainer> {
//   bool _hideError = true;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 600,
//       padding: const EdgeInsets.all(16.0),
//       decoration: getContainerDecoration(),
//       child: ListView(
//         children: [
//           const Text(
//             "Please fill the form to enroll your kid",
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           if (_hideError == false)
//             Text(
//               "Please fill all the fields",
//               textAlign: TextAlign.end,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: secondaryColor,
//               ),
//             ),
//           ...widget.formFields,
//           const SizedBox(height: 16),
//           _buildEnrollmentButton(widget.buttonText, _moveToNextFormCategory, widget.isFirst),
//         ],
//       ),
//     );
//   }

//   Widget _buildEnrollmentButton(
//       String name, VoidCallback? onPressed, bool isFirstForm) {
//     return isFirstForm
//         ? SizedBox(
//             width: double.infinity,
//             height: 61,
//             child: ElevatedButton(
//               onPressed: onPressed,
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16.0),
//                   ),
//                 ),
//                 backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
//               ),
//               child: Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           )
//         : Row(
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   height: 61,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Handle back button press
//                       _moveToPreviousFormCategory();
//                     },
//                     style: ButtonStyle(
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                       ),
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(secondaryColor),
//                     ),
//                     child: const Text(
//                       "Back",
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: SizedBox(
//                   height: 61,
//                   child: ElevatedButton(
//                     onPressed: onPressed,
//                     style: ButtonStyle(
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                       ),
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(primaryColor),
//                     ),
//                     child: Text(
//                       name,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//   }


//     void _moveToNextFormCategory() {
//     setState(() {
//       if (areFieldsNotEmpty()) {
//         if (_currentFormCategory < _formCategories.length - 1) {
//           _hideError = true;
//           _currentFormCategory++;
//         } else {
//           _enrollStudent();
//         }
//       } else {
//         _hideError = false;
//       }
//     });
//   }

//    void _moveToPreviousFormCategory() {
//     if (_currentFormCategory > 0) {
//       setState(() {
//         _currentFormCategory--;
//       });
//     }
//   }


  
// }

