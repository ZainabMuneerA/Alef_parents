import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alef_parents/injection_container.dart' as di;
import '../../../../core/app_theme.dart';
import '../../../../core/shared/Navigation/presentation/widget/ArchWidget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../core/widget/profilePic.dart';
import '../../../enroll_student/presentation/pages/EnrollStudent.dart';

import '../bloc/search/search_bloc.dart';
import '../widgets/ImageGallery.dart';
import '../widgets/message_display.dart';

class PreschoolProfile extends StatefulWidget {
  final int preschoolId;

  const PreschoolProfile({Key? key, required this.preschoolId})
      : super(key: key);

  @override
  _PreschoolProfileState createState() => _PreschoolProfileState();
}

class _PreschoolProfileState extends State<PreschoolProfile> {
  // bool _isEnglishEnabled = true;
  // late Future<SearchState> _searchFuture;
  late String _preschoolName;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (_) => di.sl<SearchBloc>()
            ..add(GetPreschoolByIdEvent((widget.preschoolId))),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Clip the background image using the ArchClipper widget
                  ClipPath(
                    clipper: ArchClipper(),
                    child: Container(
                      color: primaryColor,
                      height: 350,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        // Handle the back button press
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 16,
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is LoadedSearchIdState) {
                          return IconButton(
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              showLocationSelectionBottomSheet(
                                context,
                                state.preschool.address!.latitude,
                                state.preschool.address!.longitude,
                              );
                            },
                          );
                        } else {
                          return const SizedBox
                              .shrink(); // or return a default widget
                        }
                      },
                    ),
                  ),

                  _preschoolHeader(),
                  // const SizedBox(height: 20,),
                  _profileSummary(),
                ],
              ),
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
                if (state is LoadedSearchIdState) {
                  return _mainBody(state.preschool);
                } else {
                  return const LoadingWidget();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainBody(Preschool preschool) {
    return Column(
      children: [
        _locationContainer(),
        const SizedBox(height: 16),
        _ageContainer(),
        const SizedBox(height: 16),
        _currsContainer(),
        const SizedBox(height: 16),
        // _informationContainer(),
        const SizedBox(height: 16),
        Container(
          width: 350,
          height: 280,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ImageGallery(
              imageUrls: preschool.file != null && preschool.file!.isNotEmpty
                  ? preschool.file!
                  : ['lib/assets/images/imageHolder.jpeg'],
            ),
          ),
        ),
        _registerContactWidget(),
      ],
    );
  }

  void showLocationSelectionBottomSheet(
      BuildContext context, double latitude, double longitude) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      size: 24,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text('Google Maps'),
                  ],
                ),
                onTap: () {
                  openInGoogleMaps(latitude, longitude);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _preschoolHeader() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          _preschoolName = state.preschool.preschool_name;
          return Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),

                  ProfilePic(imageUrl: state.preschool.logo ?? null),
                  const SizedBox(height: 16),
                  Text(
                    state.preschool.preschool_name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8), // Reduce the height value here
                ],
              ),
            ),
          );
        } else {
          // Handle other states or return a default widget
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _locationContainer() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          // Access data from the state and use it
          return Container(
            width: 350,
            // height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor), // Border color
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints(
              minHeight: 100,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_city,
                  color: primaryColor,
                  size: 36,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location ',
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8), // TODO: fix this
                    Text(
                      "${state.preschool.address!.area} Building: ${state.preschool.address!.building}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                      maxLines: 6,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // Handle other states or return a default widget
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _ageContainer() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          // Access data from the state and use it
          return Container(
            width: 350,
            // height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor), // Border color
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints(
              minHeight: 100,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.child_care_outlined,
                  color: primaryColor,
                  size: 36,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Age ',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We accept students between the ages of ${state.preschool.minimum_age} to ${state.preschool.maximum_age}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        softWrap: true, // Allow text to wrap to the next line
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle other states or return a default widget
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _currsContainer() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          // Access data from the state and use it
          return Container(
            width: 350,
            // height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor), // Border color
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints(
              minHeight: 100,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.my_library_books_outlined,
                  color: primaryColor,
                  size: 36,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Our system ',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Curriculum: ${state.preschool.curriculum}\nDececription: ${state.preschool.description}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        softWrap: true, // Allow text to wrap to the next line
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle other states or return a default widget
          return const SizedBox.shrink();
        }
      },
    );
  }

  //information container
  // Widget _informationContainer() {
  //   return BlocBuilder<SearchBloc, SearchState>(
  //     builder: (context, state) {
  //       if (state is LoadedSearchIdState) {
  //         return Container(
  //           width: 350,
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               color: primaryColor,
  //             ),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           constraints: const BoxConstraints(
  //             minHeight: 300,
  //           ),
  //           child: Text(
  //             'Max Age: ${state.preschool.maximum_age}\n' +
  //                 'Min Age: ${state.preschool.minimum_age}\n' +
  //                 'Curriculum: ${state.preschool.curriculum ?? 'Not announced'}\n' +
  //                 'Registration Fees: ${state.preschool.registration_fees} BHD\n' +
  //                 'Contact Number: ${state.preschool.phone}\n',
  //             style: const TextStyle(
  //               fontSize: 18,
  //               color: Colors.grey,
  //             ),
  //           ),
  //         );
  //       } else {
  //         // Handle other states or return a default widget
  //         return const SizedBox.shrink();
  //       }
  //     },
  //   );
  // }

  Widget _profileSummary() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(30, 290, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '+${state.preschool.minimum_age}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  '|',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  'BHD ${state.preschool.monthly_fees ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  '|',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  '${state.preschool.address!.area ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        } else {
          // Handle other states or return a default widget
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _registerContactWidget() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          return Container(
            height: 100,
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle contact preschool button press
                    if (state.preschool.phone != null) {
                      print("Contact Preschool button pressed");
                      _launchWhatsApp(state.preschool.phone!.toString());
                    } else {
                      // Display a SnackBar if the phone number is null
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No phone number for this preschool"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    backgroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                  ),
                  child: const Text(
                    "Contact Preschool",
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _preschoolName = state.preschool.preschool_name;
                    Navigator.pushNamed(
                      context,
                      '/enroll',
                      arguments: {
                        'preschoolId': state.preschool.preschool_id,
                        'preschoolName': state.preschool.preschool_name
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle other states or return a default widget
          return const SizedBox.shrink();
        }
      },
    );
  }

  _launchWhatsApp(String preschoolWhatsAppNumber) async {
    final urlWhatsApp = "https://wa.me/$preschoolWhatsAppNumber";
    print(urlWhatsApp);
    _launchMapUrl(Uri.parse(urlWhatsApp));
  }

  void openInGoogleMaps(double latitude, double longitude) {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    _launchMapUrl(Uri.parse(googleMapsUrl));
  }

  void _launchMapUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch');
    }
  }
}
