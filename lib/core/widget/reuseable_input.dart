import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';


class ReusableInputField extends StatelessWidget {
  final String label;
  final TextEditingController inputController;
  final TextInputType keyboardType;
  final String hintText;
  final bool isNumeric;
  final bool isMultiline;
  final bool isEmail;
  final bool isPassword;
  //static  primaryColor = primaryColor;
  static const accentColor = Color(0xffffffff);
  static const errorColor = Color(0xffEF4444);

  const ReusableInputField({
    Key? key,
    required this.label,
    required this.inputController,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.isNumeric = false,
    this.isMultiline = false,
    this.isPassword = false,
    this.isEmail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontWeight: FontWeight.normal,
          //     color: Colors.white.withOpacity(.9),
          //   ),
          // ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(12, 26),
                    blurRadius: 50,
                    spreadRadius: 0,
                    color: Colors.grey.withOpacity(.1),
                  ),
                ],
              ),
              child: isMultiline
                  ? buildMultilineTextField()
                  : TextField(
                      controller: inputController,
                      readOnly: isEmail,
                      obscureText: isPassword, // Set to true for password
                      onChanged: (value) {
                        // Do something with the value
                      },
                      keyboardType:
                          isNumeric ? TextInputType.number : keyboardType,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: isEmail ? null : label,
                        labelStyle:  TextStyle(color: primaryColor),
                        filled: true,
                        fillColor: accentColor,
                        hintText: hintText,
                        hintStyle:  TextStyle(color: primaryColor),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                               BorderSide(color: primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                               BorderSide(color: primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: errorColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                               BorderSide(color: primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMultilineTextField({String? hintText}) {
    return TextField(
      controller: inputController,
      onChanged: (value) {
        // Do something with the value
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style:  TextStyle(fontSize: 14, color: primaryColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
        contentPadding: const EdgeInsets.all(20.0),
        border:  OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}

class FloatingLabelTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController inputController;

  const FloatingLabelTextField(
      {Key? key, this.hintText, required this.inputController})
      : super(key: key);

  @override
  _FloatingLabelTextFieldState createState() => _FloatingLabelTextFieldState();
}

class _FloatingLabelTextFieldState extends State<FloatingLabelTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: widget.inputController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          labelText: _isFocused ? widget.hintText : null,
          labelStyle: TextStyle(
            color: _isFocused
                ? primaryColor
                : primaryColor,
          ),
          hintText: _isFocused ? null : widget.hintText,
          hintStyle:  TextStyle(color: primaryColor),
          contentPadding: const EdgeInsets.all(20.0),
          border: OutlineInputBorder(
            borderSide:
                 BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                 BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _isFocused = value.isNotEmpty;
          });
        },
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        onEditingComplete: () {
          setState(() {
            _isFocused = false;
          });
        },
        onSubmitted: (value) {
          setState(() {
            _isFocused = false;
          });
        },
      
      ),
    );
  }
}

