import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widget/reuseable_input.dart';

class EnrollStudent extends StatefulWidget {
  @override
  _EnrollStudentState createState() => _EnrollStudentState();
}

class _EnrollStudentState extends State<EnrollStudent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _primaryContactController = TextEditingController();
  TextEditingController _secondaryContactController = TextEditingController();
  TextEditingController _medicalHistoryController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 30, 16, 0),
        child: _formContainer(),
      ),
    );
  }

  void _submitForm() {
    // Handle form submission logic here
    String name = _nameController.text;
    int age = int.parse(_ageController.text);
    String primaryContact = _primaryContactController.text;
    String secondaryContact = _secondaryContactController.text;
    String medicalHistory = _medicalHistoryController.text;

    // Use the form data as needed
    // ...

    // Optionally, you can reset the form after submission
    _formKey.currentState?.reset();
  }


  Widget _formContainer() {
    return Container(
      height: 600,
      padding: EdgeInsets.all(16.0),
      decoration: getContainerDecoration(),
      child: ListView(
        children: [
          const Text(
            "Please fill the form to enroll your kid",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          // const SizedBox(height: 16),
          ReusableInputField(
            label: 'Name',
            inputController: _nameController,
          ),
          ReusableInputField(
            label: 'CPR',
            isNumeric: true,
            inputController: _ageController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 25),
          _datePickerInput(),
          ReusableInputField(
            label: 'Primary Contact Number',
            isNumeric: true,
            inputController: _primaryContactController,
          ),
          ReusableInputField(
            label: 'Secondary Contact Number',
            isNumeric: true,
            inputController: _secondaryContactController,
          ),
          const SizedBox(height: 16),
          FloatingLabelTextField(hintText: "Medical History"),

          const SizedBox(height: 16),
          _buildEnrollmentButton(),
        ],
      ),
    );
  }

  Widget _buildEnrollmentButton() {
    return SizedBox(
      width: double.infinity,
      height: 61,
      child: ElevatedButton(
        onPressed: _handleEnrollmentButtonPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        child: const Text(
          'Confirm Appointment',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _datePickerInput() {
    return TextField(
      controller: _dobController,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color.fromARGB(255, 87, 77, 205),
        ),
        filled: true,
        fillColor: Color(0xffffffff),
        hintText: 'Select Date',
        hintStyle: TextStyle(color: Color(0xff6D28D9)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 87, 77, 205), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff6D28D9), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 87, 77, 205), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void _handleEnrollmentButtonPressed() {
    print("hii :P");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dobController.text) {
      setState(() {
        _dobController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }
}
