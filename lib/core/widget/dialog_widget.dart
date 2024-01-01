import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../app_theme.dart';

class DialogFb1 extends StatelessWidget {
  final bool isError;
  final String subText;
  final String btnText;
  final VoidCallback onPressed;

  DialogFb1({
    Key? key,
    required this.isError,
    required this.subText,
    required this.btnText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String animationUrl = isError
        ? 'https://lottie.host/0007c4d7-2df0-475a-b1b9-cf035c3f8d91/IuWgxkAIYz.json'
        : 'https://lottie.host/8049b1a9-cdfd-420a-936d-18e6bcfb46ac/XaJDASzUt0.json';

    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 2,
              color: Colors.grey.withOpacity(0.3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Lottie.network(
                  animationUrl,
                  width: 70,
                  height: 70,
                  repeat: true,
                ),
              ),
            ),
            Text(
              isError ? "Error" : "Success",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3.5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(text: btnText, onPressed: onPressed),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: MaterialStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}
