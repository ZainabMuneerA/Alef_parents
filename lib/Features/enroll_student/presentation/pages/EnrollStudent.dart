import 'dart:async';
import 'dart:io';

import 'package:alef_parents/Features/enroll_student/domain/entity/ApplicationRequest.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/Enrollment.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/EnrollmentStatus.dart';
import 'package:alef_parents/Features/enroll_student/presentation/bloc/GuardianType/bloc/guardian_type_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/search/search_bloc.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widget/app_bar.dart';
import '../../../../core/widget/dialog_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../core/widget/reuseable_input.dart';
import '../../../../framework/Permissions/permission_manager.dart';
import '../../../../framework/services/Debouncer.dart';
import '../../../../framework/shared_prefrences/UserPreferences.dart';
import '../../../Login/presentation/pages/LoginPage.dart';
import '../../data/model/Enrollment.dart';
import '../../domain/entity/guardianType.dart';
import '../bloc/Application/application_bloc.dart';
import '../widgets/DropdownWidget.dart';

import 'package:async/async.dart';

class EnrollStudent extends StatefulWidget {
  final int preschoolId;
  final String preschoolName;
  const EnrollStudent(
      {super.key, required this.preschoolId, required this.preschoolName});

  @override
  _EnrollStudentState createState() => _EnrollStudentState();
}

class _EnrollStudentState extends State<EnrollStudent> {
  late final String savedEmail;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cprController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  Gender? _selectedGender;
  GuardianType? _selectedGuardianType;
  String? _selectedGrade;
  late File _personalPicturePath;
  late File _certificateOfBirthPath;
  late File _passportPath;
  bool _isPersonalPictureSelected = false;
  bool _isCertificateOfBirthSelected = false;
  bool _isPassportSelected = false;
  late bool _hideError = true;
  bool _isLoading = false;

  //
  late int _currentFormCategory;
  late List<Widget Function()> _formCategories;

  //permission
  PermissionManager permissionManager = PermissionManager();

  @override
  void initState() {
    super.initState();
    _currentFormCategory = 0; // Starting with the first category
    _formCategories = [
      _formContainer,
      _formGuardianContainer,
      _formPreschoolContainer,
    ];

    // Fetch the saved email from shared preferences
    UserPreferences.getEmail().then((email) {
      if (email != null) {
        setState(() {
          savedEmail = email;
          _emailController.text = email;
        });
      } else {
        return DialogFb1(
          isError: true,
          subText: 'You are not logged in, please login and try again',
          btnText: 'Login',
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GuardianTypeBloc>(
          create: (_) => di.sl<GuardianTypeBloc>()..add(GetGuardianTypeEvent()),
        ),
        BlocProvider<ApplicationBloc>(
          create: (_) => di.sl<ApplicationBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => di.sl<SearchBloc>()
            ..add(GetPreschoolGradesEvent(widget.preschoolId)),
        ),
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
            title: 'Enrollment Form',
            showBackButton: true,
          ),
        ),
       body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0), // Adjust the horizontal padding as needed
        child: BlocBuilder<GuardianTypeBloc, GuardianTypeState>(
          builder: (context, guardianState) {
            return BlocBuilder<SearchBloc, SearchState>(
              builder: (context, gradeState) {
                if (guardianState is LoadedGuadianType &&
                    gradeState is LoadedGradesState) {
                  if (_isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                    child: _formCategories[_currentFormCategory](),
                  );
                } else {
                  return const LoadingWidget();
                }
              },
            );
          },
        ),
      ),
    ),
  );
}

  void _moveToNextFormCategory() {
    setState(() {
      if (areFieldsNotEmpty()) {
        if (_currentFormCategory < _formCategories.length - 1) {
          _hideError = true;
          _currentFormCategory++;
        } else {
          _enrollStudent();
        }
      } else {
        _hideError = false;
      }
    });
  }

  void _moveToPreviousFormCategory() {
    if (_currentFormCategory > 0) {
      setState(() {
        _currentFormCategory--;
      });
    }
  }

  bool areFieldsNotEmpty() {
    switch (_currentFormCategory) {
      case 0:
        _hideError = false;
        return _nameController.text.isNotEmpty &&
            _cprController.text.isNotEmpty &&
            _cprController.text.length == 9 &&
            _dobController.text.isNotEmpty &&
            _medicalHistoryController.text.isNotEmpty;
      case 1:
        _hideError = false;
        return _guardianNameController.text.isNotEmpty &&
            _contactNumberController.text.isNotEmpty &&
            _contactNumberController.text.length >= 8 &&
            _selectedGuardianType !=
                null && // Check if _selectedGuardianType is not null
            _selectedGuardianType!
                .valueName.isNotEmpty; // Check if valueName is not empty

      case 2:
        _hideError = false;
        return _emailController.text.isNotEmpty &&
            _selectedGrade !=
                null && // Check if _selectedGuardianType is not null
            _selectedGrade!.isNotEmpty && // Check if valueName is not empty &&
            _personalPicturePath != null &&
            _certificateOfBirthPath != null &&
            _passportPath != null &&
            _personalPicturePath.path.isNotEmpty &&
            _certificateOfBirthPath.path.isNotEmpty &&
            _passportPath.path.isNotEmpty;
      default:
        return false;
    }
  }

  void _enrollStudent() async {
    try {
      // Check if the user is logged in
      int? userId = await UserPreferences.getUserId();

      if (userId != null && savedEmail != null) {
     
        // User is logged in, proceed with enrollment
        ApplicationRequest request = ApplicationRequest(
          email: savedEmail,
          preschoolId: widget.preschoolId,
          guardianType: _selectedGuardianType!.valueName,
          studentName: _nameController.text,
          guardianName: _guardianNameController.text,
          studentCPR: int.parse(_cprController.text),
          gender: _selectedGender?.toString().split('.')[1] ?? '',
          grade: _selectedGrade!,
          phone: _contactNumberController.text,
          studentDOB: DateTime.parse(_dobController.text),
          medicalHistory: _medicalHistoryController.text,
          createdBy: userId,
          personalPicturePath: _personalPicturePath,
          certificateOfBirthPath: _certificateOfBirthPath,
          passportPath: _passportPath,
        );

        ApplicationBloc applicationBloc = di.sl<ApplicationBloc>();
        setState(() {
          _isLoading = true;
        });

        var failureOrEnrollment =
            await applicationBloc.applyToPreschoolUseCase(request);

        try {
          // Check if the result is an error or a successful enrollment
          // ignore: unnecessary_type_check
          if (failureOrEnrollment is dartz.Either<Failure, Enrollment>) {
            failureOrEnrollment.fold(
              (failure) {
                // Show error message
                _showErrorDialog("There was an error");
              },
              (enrollment) {
                // Check the enrollment status
                if (enrollment.application.status.toLowerCase() == 'waitlist') {
                  // Navigate to the home page
                  Navigator.pushNamed(context, '/home');
                } else {
                  // Show success dialog
                  _showSuccessDialog(enrollment.application.id);
                }
                _showSuccessDialog(enrollment.application.id);
              },
            );
          }//added this
         }on NoDataYetException catch (e){
                     _showErrorDialog(e.message);
       
        } catch (error) {
          _showErrorDialog('Unexpected error occurred');
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      _showErrorDialog('Unexpected error occurred');
    }
  }

  void _showSuccessDialog(int enrollmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogFb1(
          isError: false,
          subText: 'Regitered Successfully',
          btnText: 'Schedule an appointment',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/schedule',
              arguments: {
                'preschoolId': widget.preschoolId,
                'applicationId': enrollmentId,
                'preschoolName': widget.preschoolName,
              },
            );
          },
        );
      },
    );
  }

  void _showErrorDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogFb1(
          isError: true,
          subText: 'There is an error $content, try again',
          btnText: 'Try again',
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pop(); // Navigate back to the previous page
          },
        );
      },
    );
  }

//* widgets start
  Widget _buildFormContainer(List<Widget> formFields, String buttonText,
      Function() buttonOnPressed, bool isFirst) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(16.0),
      decoration: getContainerDecoration(),
      child: ListView(
        children: [
          const Text(
            "Please fill the form to enroll your kid",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          if (_hideError == false)
            Text(
              "Please fill all the fields",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14,
                color: secondaryColor,
              ),
            ),
          ...formFields,
          const SizedBox(height: 16),
          _buildEnrollmentButton(buttonText, _moveToNextFormCategory, isFirst),
        ],
      ),
    );
  }

  Widget _formContainer() {
    return _buildFormContainer([
      ReusableInputField(
          label: 'Student Name', inputController: _nameController),
      const SizedBox(height: 22),
      _datePickerInput(),
      ReusableInputField(
          label: 'Student CPR',
          isNumeric: true,
          inputController: _cprController),
      const SizedBox(height: 16),
      genderDropdown(context),
      const SizedBox(height: 16),
      FloatingLabelTextField(
          hintText: "Medical History",
          inputController: _medicalHistoryController),
    ], "Next", _moveToNextFormCategory, true);
  }

  Widget _formGuardianContainer() {
    return _buildFormContainer([
      ReusableInputField(
        label: 'Guardian Name',
        inputController: _guardianNameController,
      ),
      ReusableInputField(
        label: 'Contact Number',
        isNumeric: true,
        inputController: _contactNumberController,
      ),
      const SizedBox(height: 25),
      _guardianTypeDropdown(),
    ], "Next", _moveToNextFormCategory, false);
  }

  Widget _formPreschoolContainer() {
    return

        _buildFormContainer([
      ReusableInputField(
          label: savedEmail, isEmail: true, inputController: _emailController),
      const SizedBox(height: 25),
      _gradeDropdown(),
      const SizedBox(height: 25),
      _buildFilePickerButton(
        label: 'Select Personal Picture',
        onFilePicked: (File file) {
          setState(() {
            _personalPicturePath = file;
            _isPersonalPictureSelected = true;
          });
        },
        isSelected: _isPersonalPictureSelected,
      ),
      const SizedBox(height: 16),
      _buildFilePickerButton(
        label: 'Please upload birth certificate',
        onFilePicked: (File file) {
          setState(() {
            _certificateOfBirthPath = file;
            _isCertificateOfBirthSelected = true;
          });
        },
        isSelected: _isCertificateOfBirthSelected,
      ),
      const SizedBox(height: 16),
      _buildFilePickerButton(
        label: 'Please upload passport',
        onFilePicked: (File file) {
          setState(() {
            _passportPath = file;
            _isPassportSelected = true;
          });
        },
        isSelected: _isPassportSelected,
      ),
      const SizedBox(height: 16),
    ], "Submit", _moveToNextFormCategory, false);
  }

  Widget _buildFilePickerButton({
    required String label,
    required Function(File) onFilePicked,
    required bool isSelected,
  }) {
    return Column(
      children: [
        DottedBorder(
          dashPattern: const [6, 3],
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          color: primaryColor,
          padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
          child: OutlinedButton(
            onPressed: () async {
              showUploadSelectionBottomSheet(context, (selectedOption) async {
                if (selectedOption == 'camera') {
                  File? pickedFile = await permissionManager.openCameraApp();
                  if (pickedFile != null) {
                    onFilePicked(pickedFile);
                  }
                } else if (selectedOption == 'photos') {
                  File? pickedFile = await permissionManager.openPhotoApp();
                  if (pickedFile != null) {
                    onFilePicked(pickedFile);
                  }
                } else if (selectedOption == 'files') {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    onFilePicked(File(file.path!));
                  }
                }
              });
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(width: 1.0, style: BorderStyle.none),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.file_upload),
                const SizedBox(width: 8),
                Text(label),
              ],
            ),
          ),
        ),
        if (isSelected)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              "* ${path.basename(_getSelectedFilePath(label))}",
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }

  String _getSelectedFilePath(String label) {
    switch (label) {
      case 'Select Personal Picture':
        return _personalPicturePath.path;
      case 'Please upload birth certificate':
        return _certificateOfBirthPath.path;
      case 'Please upload passport':
        return _passportPath.path;
      default:
        return '';
    }
  }

  Widget _buildEnrollmentButton(
      String name, VoidCallback? onPressed, bool isFirstForm) {
    return isFirstForm
        ? SizedBox(
            width: double.infinity,
            height: 61,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              ),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 61,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle back button press
                      _moveToPreviousFormCategory();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(secondaryColor),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 61,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                    ),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget _datePickerInput() {
    return TextField(
      controller: _dobController,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        labelStyle:  TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: primaryColor,
        ),
        filled: true,
        fillColor: const Color(0xffffffff),
        hintText: 'Select Date',
        hintStyle:  TextStyle(color: primaryColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        border: OutlineInputBorder(
          borderSide:  BorderSide(
              color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(
              color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
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

  Widget genderDropdown(BuildContext context) {
    return ReusableDropdown<Gender>(
      items: Gender.values,
      hintText: 'Gender',
      selectedValue: _selectedGender,
      displayFunction: (Gender gender) {
        switch (gender) {
          case Gender.male:
            return 'Male';
          case Gender.female:
            return 'Female';
        }
      },
      onChanged: (Gender? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
        // Handle dropdown value change
        if (newValue != null) {
        }
      },
    );
  }

  Widget _guardianTypeDropdown() {
    return BlocBuilder<GuardianTypeBloc, GuardianTypeState>(
      builder: (context, state) {
        if (state is LoadedGuadianType) {
          return ReusableDropdown<GuardianType>(
            items: state.guardianType,
            selectedValue: _selectedGuardianType,
            displayFunction: (GuardianType guardianType) =>
                guardianType.valueName,
            onChanged: (GuardianType? newValue) {
              // Handle dropdown value change
              setState(() {
                _selectedGuardianType = newValue;
              });
              if (newValue != null) {
              }
            },
            hintText: 'Guardian Type',
          );
        } else if (state is ErrorGuadianType) {
          return const Text('Error loading guardian types');
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  Widget _gradeDropdown() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedGradesState) {
          return ReusableDropdown<String>(
            items: state.grades,
            selectedValue: _selectedGrade,
            displayFunction: (String grade) => grade,
            onChanged: (String? newValue) {
              // Handle dropdown value change
              setState(() {
                _selectedGrade = newValue;
              });
              if (newValue != null) {
                print('Selected: ${newValue}');
              }
            },
            hintText: 'Grade',
          );
        } else if (state is ErrorSearchState) {
          return const Text('Error loading grade ');
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  void showUploadSelectionBottomSheet(
      BuildContext context, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 24,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text('Open Camera'),
                  ],
                ),
                onTap: () async {
                  bool hasPermission =
                      await permissionManager.requestCameraPermission();
                  if (hasPermission) {
                    File? pickedFile = await permissionManager.openCameraApp();

                    if (pickedFile != null) {
                      // Handle other actions after opening the camera
                      onSelect('camera');
                      print(pickedFile);
                    } else {
                      // Optionally handle the case where the user canceled or there was an issue
                      print("error");
                    }
                  } else {
                    // Handle case where permission is not granted
                    print("permission not granted");
                  }

                  // Move the Navigator.pop() outside the if conditions
                  Navigator.pop(context);
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 24,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text('Open Photos'),
                  ],
                ),
                onTap: () async {
                  bool hasPermission =
                      await permissionManager.requestPhotoPermission();
                  if (hasPermission) {
                    File? pickedFile = await permissionManager.openPhotoApp();

                    if (pickedFile != null) {
                      // Handle other actions after opening the camera
                      onSelect('photos');
                      print(pickedFile);
                    } else {
                      // Optionally handle the case where the user canceled or there was an issue
                      print("error");
                    }
                  } else {
                    // Handle case where permission is not granted
                    print("permission not granted");
                    DialogFb1(
                      isError: true,
                      subText:
                          'Permmison is not granted, please give Alef photo access',
                      btnText: 'Close',
                      onPressed: () {},
                    );
                  }

                  // Move the Navigator.pop() outside the if conditions
                  Navigator.pop(context);
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      size: 24,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text('Open Files'),
                  ],
                ),
                onTap: () async {
                  onSelect('files');
                  Navigator.pop(context);
                },
              ),
              const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  // Widget buildPreschoolListScreen(BuildContext context) {
  //   return BlocBuilder<ApplicationBloc, ApplicationState>(
  //     builder: (context, state) {
  //       print(" here$state");
  //       if (state is ApplicationInitial) {
  //         return _buildFormContainer([
  //           ReusableInputField(
  //               label: savedEmail,
  //               isEmail: true,
  //               inputController: _emailController),
  //           ReusableInputField(
  //               label: 'Grade', inputController: _gradeController),
  //           const SizedBox(height: 25),
  //           _buildFilePickerButton(
  //             label: 'Select Personal Picture',
  //             onFilePicked: (File file) {
  //               setState(() {
  //                 _personalPicturePath = file;
  //                 _isPersonalPictureSelected = true;
  //               });
  //             },
  //             isSelected: _isPersonalPictureSelected,
  //           ),
  //           const SizedBox(height: 16),
  //           _buildFilePickerButton(
  //             label: 'Please upload birth certificate',
  //             onFilePicked: (File file) {
  //               setState(() {
  //                 _certificateOfBirthPath = file;
  //                 _isCertificateOfBirthSelected = true;
  //               });
  //             },
  //             isSelected: _isCertificateOfBirthSelected,
  //           ),
  //           const SizedBox(height: 16),
  //           _buildFilePickerButton(
  //             label: 'Please upload passport',
  //             onFilePicked: (File file) {
  //               setState(() {
  //                 _passportPath = file;
  //                 _isPassportSelected = true;
  //               });
  //             },
  //             isSelected: _isPassportSelected,
  //           ),
  //           const SizedBox(height: 16),
  //         ], "Submit", _moveToNextFormCategory, false);
  //       } else if (state is LoadedEnrollmentState) {
  //         return _showSuccessDialog(state.enrollment.application.id);
  //       } else if (state is ErrorApplicationState) {
  //         return _showErrorDialog(message: state.message);
  //       }
  //       return SizedBox(); // Placeholder for other cases or return a default widget
  //     },
  //   );
  // }
//* huhuhuhuh
  // Widget buildSubmittionScreen(BuildContext context) {
  //   return BlocBuilder<ApplicationBloc, ApplicationState>(
  //     builder: (context, state) {
  //       print(" here $state");
  //       if (state is ApplicationInitial) {
  //         return _buildFormContainer([
  //           ReusableInputField(
  //               label: savedEmail,
  //               isEmail: true,
  //               inputController: _emailController),
  //           ReusableInputField(
  //               label: 'Grade', inputController: _gradeController),
  //           const SizedBox(height: 25),
  //           _buildFilePickerButton(
  //             label: 'Select Personal Picture',
  //             onFilePicked: (File file) {
  //               setState(() {
  //                 _personalPicturePath = file;
  //                 _isPersonalPictureSelected = true;
  //               });
  //             },
  //             isSelected: _isPersonalPictureSelected,
  //           ),
  //           const SizedBox(height: 16),
  //           _buildFilePickerButton(
  //             label: 'Please upload birth certificate',
  //             onFilePicked: (File file) {
  //               setState(() {
  //                 _certificateOfBirthPath = file;
  //                 _isCertificateOfBirthSelected = true;
  //               });
  //             },
  //             isSelected: _isCertificateOfBirthSelected,
  //           ),
  //           const SizedBox(height: 16),
  //           _buildFilePickerButton(
  //             label: 'Please upload passport',
  //             onFilePicked: (File file) {
  //               setState(() {
  //                 _passportPath = file;
  //                 _isPassportSelected = true;
  //               });
  //             },
  //             isSelected: _isPassportSelected,
  //           ),
  //           const SizedBox(height: 16),
  //         ], "Submit", _moveToNextFormCategory, false);
  //       } else if (state is LoadedEnrollmentState) {
  //         return DialogFb1(
  //           isError: false,
  //           subText: 'Regitered Successfully',
  //           btnText: 'Schedule an appointment',
  //           onPressed: () {
  //             Navigator.pushNamed(
  //               context,
  //               '/schedule',
  //               arguments: {
  //                 'preschoolId': widget.preschoolId,
  //                 'applicationId': state.enrollment.application.id,
  //               },
  //             );
  //           },
  //         );
  //       } else if (state is ErrorApplicationState) {
  //         return DialogFb1(
  //           isError: true,
  //           subText: state.message,
  //           btnText: 'Retry',
  //           onPressed: () {
  //             // Handle retry logic if needed
  //             Navigator.of(context).pop();
  //           },
  //         );
  //       } else {
  //         return LoadingWidget();
  //       }
  //     },
  //   );
  // }
}
