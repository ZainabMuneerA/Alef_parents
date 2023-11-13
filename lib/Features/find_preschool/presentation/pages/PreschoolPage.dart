import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alef_parents/injection_container.dart' as di;
import '../../../../core/app_theme.dart';
import '../../../../core/shared/Navigation/presentation/widget/ArchWidget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../core/widget/profilePic.dart';
import '../bloc/prschool/search/search_bloc.dart';
import '../widgets/ImageGallery.dart';
import '../widgets/PreschoolProfileWidget.dart';
import '../widgets/message_display.dart';

class PreschoolProfile extends StatefulWidget {
  final int preschoolId;

  const PreschoolProfile({Key? key, required this.preschoolId})
      : super(key: key);

  @override
  _PreschoolProfileState createState() => _PreschoolProfileState();
}

class _PreschoolProfileState extends State<PreschoolProfile> {
  bool _isEnglishEnabled = true;

  @override
  Widget build(BuildContext context) {
    print('Preschool ID: ${widget.preschoolId}');
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
                  // Positioned(
                  //   top: 25,
                  //   right: 16,
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.location_on_outlined,
                  //       color: Colors.white,
                  //       size: 30,
                  //     ),
                  //     onPressed: () {
                  //       showLocationSelectionBottomSheet(context);
                  //     },
                  //   ),
                  // ),

                  Positioned(
                    top: 25,
                    right: 16,
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is LoadedSearchIdState) {
                          return IconButton(
                            icon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              showLocationSelectionBottomSheet(
                                context,
                                state.preschool.address!.longitude,
                                state.preschool.address!.longitude,
                              );
                            },
                          );
                        } else {
                          return SizedBox
                              .shrink(); // or return a default widget
                        }
                      },
                    ),
                  ),

                  _preschoolHeader(),
                  _profileSummary(),
                ],
              ),

              // Other widgets for the user profile page, such as email address, bio, etc.
              _locationContainer(),
              const SizedBox(height: 16),
              _informationContainer(),
              const SizedBox(height: 16),
              Container(
                width: 350,
                height: 280,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ImageGallery(
                    imageUrls: [
                      'lib/assets/images/imageHolder.jpeg',
                      'lib/assets/images/imageHolder.jpeg',
                      'lib/assets/images/imageHolder.jpeg',
                    ],
                  ),
                ),
              ),
              _registerContactWidget(),
            ],
          ),
        ),
      ),
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
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.map, size: 24),
                    const SizedBox(width: 10),
                    Text('Google Maps'),
                  ],
                ),
                onTap: () {
                  openInGoogleMaps(latitude, longitude);
                },
              ),
              Divider(),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.location_on, size: 24),
                    const SizedBox(width: 10),
                    Text('Apple Maps'),
                  ],
                ),
                onTap: () {
                  openInAppleMap(latitude, longitude);
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
          return Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  const ProfilePic(
                      imageUrl: 'lib/assets/images/imageHolder.jpeg'),
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
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_city,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      state.preschool.address!.area +
                          " Building: " +
                          state.preschool.address!.building,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
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

  //information container
  Widget _informationContainer() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          return Container(
            width: 350,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints(
              minHeight: 300,
            ),
            child: Text(
              'Max Age: ${state.preschool.maximum_age}\n' +
                  'Min Age: ${state.preschool.minimum_age}\n' +
                  'Curriculum: ${state.preschool.curriculum ?? 'Not announced'}\n' +
                  'Monthly Fees: ${state.preschool.monthly_fees} BHD\n' +
                  'Contact Number: ${state.preschool.phone}\n',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
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

  Widget _profileSummary() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchIdState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(30, 260, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '+${state.preschool.minimum_age}', // Example property, replace with actual property
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '|',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  'BHD ${state.preschool.registration_fees ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '|',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  '${state.preschool.address!.area ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
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
                    _launchWhatsApp(state.preschool.phone! as String);
                  } else {
                    // Display a SnackBar if the phone number is null
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
                child: const Text(
                  "Contact Preschool",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle register button press
                  print("Register button pressed");
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 20), // Adjust spacing here
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
    _launchMapUrl(Uri.parse(urlWhatsApp));
  }

  void openInGoogleMaps(double latitude, double longitude) {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    _launchMapUrl(Uri.parse(googleMapsUrl));
  }

  void openInAppleMap(double latitude, double longitude) {
    final appleMapsURL = 'https://maps.apple.com/?q=$latitude,$longitude';
    _launchMapUrl(Uri.parse(appleMapsURL));
  }

  void _launchMapUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch');
    }
  }
}
