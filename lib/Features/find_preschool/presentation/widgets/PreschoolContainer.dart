// import 'package:flutter/material.dart';
//
// class PreschoolContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ClipRRect(
//         borderRadius: BorderRadius.circular(10), // Rounded edges with 10px radius
//         child: Container(
//           width: 250,
//           height: 250,
//           color: Colors.grey[200],
//           child: Stack(
//             children: [
//               Image.asset(
//                 'lib/assets/images/imageHolder.jpeg',
//                 fit: BoxFit.cover,
//               ),
//               const Positioned(
//                 top: 10,
//                 right: 10,
//                 child: Icon(
//                   Icons.favorite_border_rounded,
//                   color: Colors.grey,
//                   size: 24,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 40),
//                   child: const Text(
//                     'Preschool goes here',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   child: const Text(
//                     'Your location goes here',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }