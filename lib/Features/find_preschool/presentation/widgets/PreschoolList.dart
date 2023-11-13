import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/generated/intl/messages_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/loading_widget.dart';
import '../../domain/entity/preschool.dart';
import '../bloc/prschool/search/search_bloc.dart';
import '../pages/PreschoolPage.dart';
import 'message_display.dart';

class PreschoolList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;

  const PreschoolList({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 115,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 17.5,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'BHD',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 5),
                  Text(
                    price,
                    style: TextStyle(fontSize: 14),
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

// class PreschoolListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 20),
//         PreschoolList(
//           title: 'Preschool Name',
//           subtitle: 'Preschool Description',
//           price: '300',
//           imageUrl: 'lib/assets/images/imageHolder.jpeg',
//         ),
//         SizedBox(height: 20),
//         PreschoolList(
//           title: 'Preschool Name',
//           subtitle: 'Preschool Description',
//           price: '300',
//           imageUrl: 'lib/assets/images/imageHolder.jpeg',
//         ),
//         SizedBox(height: 20),
//         PreschoolList(
//           title: 'Preschool Name',
//           subtitle: 'Preschool Description',
//           price: '300',
//           imageUrl: 'lib/assets/images/imageHolder.jpeg',
//         )
//       ],
//     );
//   }
// }

// class PreschoolListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BlocBuilder<PreschoolBloc, PreschoolState>(
//           builder: (context, state) {
//             if (state is LoadingPreschoolState) {
//               print("this is the state: $state");
//               return LoadingWidget();
//             } else if (state is LoadedPreschoolState) {
//               return preschoolListing(state.preschool);
//             } else if (state is ErrorPreschoolState) {
//               return MessageDisplayWidget(message: state.message);
//             } else if (state is PreschoolInitial) {
//               // Handle the initial state if needed
//               print(state);
//               return LoadingWidget();
//             }
//             print("State type: ${state.runtimeType}");
//             return LoadingWidget();
//           },
//         ),
//       ],
//     );
//   }

  // Widget preschoolListing(List<Preschool> preschools) {
  //   return Container(
  //     height: 300, // Specify a height for the ListView
  //     child: ListView.builder(
  //       itemCount: preschools.length,
  //       itemBuilder: (context, index) {
  //         final preschool = preschools[index];
  //         return PreschoolList(
  //           title: preschool.preschool_name,
  //           subtitle: preschool.preschool_name,
  //           price: preschool.monthly_fees.toString(),
  //           imageUrl: 'lib/assets/images/imageHolder.jpeg',
  //         );
  //       },
  //     ),
  //   );
  // }
// }

// class PreschoolListing extends StatelessWidget {
//   final List<Preschool> preschools;

//   PreschoolListing({required this.preschools});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: preschools.map((preschool) {
//         return Padding(
//           padding: EdgeInsets.only(bottom: 16), 
//           child: PreschoolList(
//             title: preschool.preschool_name,
//             subtitle: preschool.address!.area,
//             price: preschool.monthly_fees.toString(),
//             imageUrl: 'lib/assets/images/imageHolder.jpeg',
//           ),
//         );
//       }).toList(),
//     );
//   }
// }


class PreschoolListing extends StatelessWidget {
  final List<Preschool> preschools;

  PreschoolListing({required this.preschools});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: preschools.map((preschool) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16), 
          child: GestureDetector(
            onTap: () {
              // Navigate to PreschoolProfile and pass the preschool_id
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreschoolProfile(preschoolId: preschool.preschool_id),
                ),
              );
            },
            child: PreschoolList(
              title: preschool.preschool_name,
              subtitle: preschool.address!.area,
              price: preschool.monthly_fees.toString(),
              imageUrl: 'lib/assets/images/imageHolder.jpeg',
            ),
          ),
        );
      }).toList(),
    );
  }
}


class PreschoolListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PreschoolBloc, PreschoolState>(
          builder: (context, state) {
            if (state is LoadingPreschoolState) {
              return LoadingWidget();
            } else if (state is LoadedPreschoolState) {
              return PreschoolListing(preschools: state.preschool);
            } else if (state is ErrorPreschoolState) {
              return MessageDisplayWidget(message: state.message);
            } else if (state is PreschoolInitial) {
              return LoadingWidget();
            }
            return LoadingWidget();
          },
        ),
      ],
    );
  }
}
