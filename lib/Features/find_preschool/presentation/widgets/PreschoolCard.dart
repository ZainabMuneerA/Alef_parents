import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/widgets/message_display.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PreschoolContainer.dart';

class PreschoolCard extends StatelessWidget {
  final List<Preschool> preschools;

  const PreschoolCard({Key? key, required this.preschools}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, bottom: 15.0),
      child: SizedBox(
        height: 300,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: preschools.map((preschool) {
            return CardWidget(
              text: preschool.preschool_name,
              imageUrl: preschool.logo ?? '',
              subtitle: preschool.address!.area, 
              id: preschool.preschool_id,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String text;
  final String? imageUrl;
  final String subtitle;
  final int id;

  const CardWidget({
    required this.text,
    required this.subtitle,
    this.imageUrl,
    Key? key, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 15),
      child: GestureDetector(
        onTap: () {
          // Navigate to PreschoolPage with the provided ID
          Navigator.pushNamed(
            context,
            '/preschool-profile',
            arguments: {'preschoolId': id},
          );
        },
        child: Container(
          width: 250,
          height: 300,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  if (imageUrl != null && imageUrl!.isNotEmpty)
                    Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    )
                  else
                    Image.asset(
                      'lib/assets/images/imageHolder.jpeg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    ),
                ],
              ),
              Spacer(),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class PreschoolCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PreschoolBloc, PreschoolState>(
          builder: (context, state) {
            print(state);
            if (state is LoadingPreschoolState) {
              return LoadingWidget();
            } else if (state is LoadedPreschoolState) {
              return PreschoolCard(preschools: state.preschool);
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
