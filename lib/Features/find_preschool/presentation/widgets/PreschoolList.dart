import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/generated/intl/messages_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/loading_widget.dart';
import '../../domain/entity/preschool.dart';
// import '../pages/PreschoolPage.dart';
import 'message_display.dart';

class PreschoolList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String? imageUrl;

  const PreschoolList({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
     this.imageUrl,
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
            offset: const Offset(0, 20),
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
                child: imageUrl !=null && imageUrl!.isNotEmpty 
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'lib/assets/images/imageHolder.jpeg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Text(
                    'BHD',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 14),
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


class PreschoolListing extends StatelessWidget {
  final List<Preschool> preschools;

  PreschoolListing({required this.preschools});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: preschools.map((preschool) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
              // Navigate to PreschoolProfile using the named route and pass the preschool_id
              Navigator.pushNamed(
                context,
                '/preschool-profile',
                arguments: {'preschoolId': preschool.preschool_id},
              );
            },
            child: PreschoolList(
              title: preschool.preschool_name,
              subtitle: preschool.address!.area,
              price: preschool.monthly_fees.toString(),
              imageUrl: preschool.logo,
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
            print(state);
            if (state is LoadingPreschoolState) {
              return const LoadingWidget();
            } else if (state is LoadedPreschoolState) {
              return PreschoolListing(preschools: state.preschool);
            } else if (state is ErrorPreschoolState) {
              return MessageDisplayWidget(message: state.message);
            } else if (state is PreschoolInitial) {
              return const LoadingWidget();
            }
            return const LoadingWidget();
          },
        ),
      ],
    );
  }
}
