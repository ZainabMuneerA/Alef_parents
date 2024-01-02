// import 'package:alef_parents/Features/find_preschool/presentation/widgets/SliderWidget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../../core/app_theme.dart';

// class FilterBottomSheet {
//     String? selectedAreas; // Initial selected areas
//     bool locationEnabled = false; // You might want to initialize this based on some condition
//     double? ageValue;

//   static void show(BuildContext context) {


//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(25.0),
//         ),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return SizedBox(
//               height: 400,
//               child: Container(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(); // Close the bottom sheet
//                           },
//                           child: const Text('Cancel'),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton(
//                               onPressed: () {
//                                 locationEnabled = false;
                                
//                                 ageValue = null;

//                                 // Implement your logic for applying filters here
//                                 // ...

//                                 setState(() {}); // Update the UI
//                               },
//                               child: const Text('Clear'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // _submitFilter();
//                                 Navigator.of(context).pop(); // Close the bottom sheet
//                               },
//                               child: const Text('Done'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     ListTile(
//                       title: Text('Filter by Location'),
//                       trailing: StatefulBuilder(
//                         builder: (BuildContext context, StateSetter setState) {
//                           return CupertinoSwitch(
//                             value: locationEnabled,
//                             onChanged: (value) {
//                               setState(() {
//                                 locationEnabled = value;
//                               });
//                             },
//                             activeColor:
//                                 const Color.fromARGB(255, 224, 224, 228),
//                             thumbColor: locationEnabled
//                                 ? primaryColor
//                                 : CupertinoColors.white,
//                             trackColor:
//                                 const Color.fromARGB(255, 225, 225, 233),
//                           );
//                         },
//                       ),
//                     ),
//                     const Divider(),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const ListTile(
//                           title: Text('Age'),
//                         ),
//                         // Replace SliderFb1 with your actual Slider widget
//                          Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const ListTile(
//                           title: Text('Age'),
//                         ),
//                         SliderFb1(
//                           min: 2.0,
//                           max: 5.0,
//                           initialValue: ageValue ?? 2.0,
//                           onChange: (double value) {
//                             setState(() {
//                               ageValue = value;
//                             });
//                             print(ageValue);
//                           },
//                         ),
//                         const Divider(),
//                       ],
//                     ),
//                     _areaWidget(),
                       
//                       ],
//                     ),
//                     // Replace _areaWidget() with your actual widget for selecting areas
//                     // _areaWidget(),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void _submitFilter() {
//     // Implement the logic for submitting filters
//     // ...
//   }







//     Widget _areaWidget() {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       child: StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Area',
//                 style: TextStyle(),
//               ),
//               SizedBox(height: 16),
//               Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: availableAreas.map((area) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Handle selection logic here
//                       setState(() {
//                         selectedArea = area;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: selectedArea == area
//                             ? primaryColor
//                             : backgroundColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         area,
//                         style: TextStyle(
//                           color:
//                               selectedArea == area ? Colors.white : Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
