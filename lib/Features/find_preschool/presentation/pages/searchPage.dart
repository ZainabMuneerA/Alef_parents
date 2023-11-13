import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/search/search_bloc.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../bloc/prschool/preschool_bloc.dart';
import '../widgets/MySearchBar.dart';
import '../widgets/PreschoolList.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:alef_parents/injection_container.dart' as di;

import '../widgets/message_display.dart';

class SearchPage extends StatefulWidget {
  final String? searchQuery;

  const SearchPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.searchQuery;
  }

  void updateSearchQuery(String value) {
    setState(() {
      searchQuery = value.isNotEmpty ? value : null;
    });
  }

  //   void _submitSearch(String query) {
  //   setState(() {
  //     searchQuery = query.isNotEmpty ? query : null;
  //   });
  //   FocusScope.of(context).unfocus(); // Dismiss the keyboard
  //   _searchController.clear(); // Clear the search query in the text field
  //   BlocProvider.of<PreschoolBloc>(context).add(RefreshPreschoolEvent()); // Reset the search state
  // }

  void _submitSearch(String query) {
    setState(() {
      searchQuery = query.isNotEmpty ? query : null;
    });

    // Retrieve the SearchBloc from the dependency injection container
    SearchBloc searchBloc = di.sl<SearchBloc>();

    // Dispatch the GetPreschoolByNameEvent to trigger a new search
    searchBloc.add(GetPreschoolByNameEvent(searchQuery!));

    FocusScope.of(context).unfocus(); // Dismiss the keyboard
    _searchController.clear(); // Clear the search query in the text field
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (_) =>
              di.sl<SearchBloc>()..add(GetPreschoolByNameEvent((searchQuery!))),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: MySearchBar(
                        onSearch: _submitSearch,
                        searchController: _searchController,
                      ),
                    ),
                    const SizedBox(width: 4),
                    filterButton(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (searchQuery == null || searchQuery!.isEmpty)
                PreschoolListScreen()
              else
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return SearchListScreen();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        requestLocationPermission(context);
      },
    );
  }

  void requestLocationPermission(BuildContext context) async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      //check the service
      _serviceEnabled =
          await location.requestService(); //request if not granted
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      print(_permissionGranted);
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print("location is...");
    _locationData = await location.getLocation();
    print("hy" + _locationData.toString());
  }

  // void requestLocationPermission(BuildContext context) async {
  //   PermissionStatus status = await Permission.location.request();
  //   if (status.isGranted) {
  //     // Permission granted
  //     Position? currentPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     if (currentPosition != null) {
  //       // Use the current location for further processing
  //       print(
  //           'Current Location: ${currentPosition.latitude}, ${currentPosition.longitude}');
  //       // TODO: Perform actions with the obtained location
  //     } else {
  //       // Unable to retrieve current location
  //       print('Unable to retrieve current location');
  //       // TODO: Handle error or show a message to the user
  //     }
  //   } else {
  //     // Permission denied
  //     if (status.isPermanentlyDenied) {
  //       // Permission permanently denied, open app settings
  //       openAppSettings();
  //     } else {
  //       // Permission denied but not permanently, show a message to the user
  //       _showLocationPermissionDeniedDialog(context);
  //     }
  //   }
  // }

  void _showLocationPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission'),
          content: Text(
              'Location permission is required to access your current location.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                // openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}

class SearchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("used");
    return Column(
      children: [
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            print(state);
            if (state is LoadingSearchState) {
              return LoadingWidget();
            } else if (state is LoadedSearchState) {
              return PreschoolListing(
                preschools: state.preschool,
              );
            } else if (state is ErrorSearchState) {
              return MessageDisplayWidget(message: state.message);
            } else if (state is SearchInitial) {
              return LoadingWidget();
            }
            return LoadingWidget();
          },
        ),
      ],
    );
  }
}
