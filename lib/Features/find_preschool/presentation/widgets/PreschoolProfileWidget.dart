// import 'package:flutter/material.dart';

// import '../../domain/entity/preschool.dart';

// class PreschoolPrefileWidget extends StatelessWidget {
//   final List<Preschool> preschools;

//   const PreschoolPrefileWidget({Key? key, required this.preschools})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Access the first preschool in the list (if available)
//     final preschool = preschools.isNotEmpty ? preschools.first : null;

//     return Container(
//       padding: EdgeInsets.all(30),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(
//             '${preschool?.maximum_age ?? 0}', // Example property, replace with actual property
//             style: TextStyle(fontSize: 16),
//           ),
//           Text(
//             '|',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           Text(
//             'BHD ${preschool?.monthly_fees ?? 0}', // Example property, replace with actual property
//             style: TextStyle(fontSize: 16),
//           ),
//           Text(
//             '|',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           Text(
//             '${preschool?.address?.area ?? 'Unknown'}', // Example property, replace with actual property
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }
