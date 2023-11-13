import 'package:flutter/material.dart';

import 'PreschoolContainer.dart';

class PreschoolCard extends StatelessWidget {
  const PreschoolCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, bottom: 15.0),
      child: SizedBox(
        height: 300,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            CardWidget(
              text: "Farawla Preschool",
              imageUrl: "lib/assets/images/imageHolder.jpeg",
              subtitle: "Manama",
            ),
            CardWidget(
              text: "Farawla Preschool",
              imageUrl: "lib/assets/images/imageHolder.jpeg",
              subtitle: "Manama",
            ),
            CardWidget(
              text: "Farawla Preschool",
              imageUrl: "lib/assets/images/imageHolder.jpeg",
              subtitle: "Manama",
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;

  const CardWidget({
    required this.text,
    required this.imageUrl,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 15),
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
                Image.asset(imageUrl, fit: BoxFit.cover),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
    );
  }
}