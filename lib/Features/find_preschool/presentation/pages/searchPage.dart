import 'dart:ffi';

import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:alef_parents/framework/Permissions/permission_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../../../../core/app_theme.dart';
import '../bloc/prschool/preschool_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../widgets/MySearchBar.dart';
import '../widgets/PreschoolList.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:alef_parents/injection_container.dart' as di;

import '../widgets/SliderWidget.dart';
import '../widgets/message_display.dart';
import 'package:alef_parents/Features/find_preschool/data/model/cities.dart';

class SearchPage extends StatefulWidget {
  final String? searchQuery;

  const SearchPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  String? searchQuery;
  double? ageValue = 3;
  double? long;
  double? lat;
  bool locationEnabled = false;
  String? selectedArea;
  double? selectedAge;
 double? userLatitude;
    double? userLongitude;

  late SearchBloc searchBloc;
  late PermissionManager permissionManager;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.searchQuery;
    if (searchQuery != null) {
      searchBloc = di.sl<SearchBloc>()
        ..add(GetPreschoolByNameEvent(name: searchQuery));
    } else {
      searchBloc = di.sl<SearchBloc>()..add(GetPreschoolByNameEvent());
    }
    permissionManager = PermissionManager();
  }

  void updateSearchQuery(String value) {
    setState(() {
      searchQuery = value.isNotEmpty ? value : null;
    });
  }

  void _submitSearch(String query) {
    setState(() {
      searchQuery = query.isNotEmpty ? query : null;
    });

    searchBloc.add(
      GetPreschoolByNameEvent(
        name: searchQuery,
      ),
    );

    _searchController.clear();
  }

  void _submitFilter(
    String? query,
  ) async {
    setState(() {
      searchQuery = query;
    });

    int? age = null;
    if (selectedAge != null) {
      age = selectedAge!.toInt();
    }

    if (locationEnabled) {
      bool hasLocationPermission = await permissionManager.requestLocationPermission();
      print(hasLocationPermission);
      if (hasLocationPermission) {
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          userLatitude = position.latitude;
          userLongitude = position.longitude;
        } catch (e) {
          // Handle location error
          print('Error getting location: $e');
        }
      }
    } else {
      print("No premission please grant Alef location premission");
    }

    searchBloc.add(
      GetPreschoolByNameEvent(
        name: searchQuery,
        age: age,
        area: selectedArea,
        longitude: userLatitude,
        latitude: userLongitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: searchBloc),
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
              if (searchQuery == null)
                // || searchQuery!.isEmpty)
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
        locationEnabled = false;
        selectedArea = null;
        // ageValue = null;
        selectedAge = null;
        showFilterBottomSheet();
      },
    );
  }

  void showFilterBottomSheet() {
    // List<String> selectedAreas = [];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 400,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  locationEnabled = false;
                                  selectedArea = null;
                                  // ageValue = null;
                                  selectedAge = null;
                                });
                              },
                              child: const Text('Clear'),
                            ),
                            TextButton(
                              onPressed: () {
                                _submitFilter(
                                  _searchController.text ?? '',
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Apply'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListTile(
                      title: const Text('Filter by Location'),
                      trailing: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return CupertinoSwitch(
                            value: locationEnabled,
                            onChanged: (value) {
                              setState(() {
                                locationEnabled = value;
                              });
                            },
                            activeColor:
                                const Color.fromARGB(255, 224, 224, 228),
                            thumbColor: locationEnabled
                                ? primaryColor
                                : CupertinoColors.white,
                            trackColor:
                                const Color.fromARGB(255, 225, 225, 233),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ListTile(
                          title: Text('Age'),
                        ),
                        SliderFb1(
                          min: 1.0,
                          max: 5.0,
                          initialValue: ageValue ?? 2.0,
                          onChange: (double value) {
                            setState(() {
                              ageValue = value;
                              selectedAge = value;
                            });
                            // print(ageValue);
                          },
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    _areaWidget(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _areaWidget() {
    List<City> cities = City.sortByName(getCities());

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Area',
                style: TextStyle(),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: cities.map((city) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedArea = city.name;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: selectedArea == city.name
                              ? primaryColor
                              : backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          city.name,
                          style: TextStyle(
                            color: selectedArea == city.name
                                ? Colors.white
                                : Colors.grey,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
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
            if (state is LoadingSearchState) {
              return const LoadingWidget();
            } else if (state is LoadedSearchState) {
              return PreschoolListing(
                preschools: state.preschool,
              );
            } else if (state is ErrorSearchState) {
              return MessageDisplayWidget(message: state.message);
            }
            return const LoadingWidget();
          },
        ),
      ],
    );
  }
}
