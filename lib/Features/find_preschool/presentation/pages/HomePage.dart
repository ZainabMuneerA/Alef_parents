import 'package:alef_parents/Features/find_preschool/presentation/pages/searchPage.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/Navigation/presentation/widget/AppNavigationBar.dart';
import '../../../../main.dart';
import '../widgets/MySearchBar.dart';
import '../widgets/PreschoolCard.dart';
import '../widgets/PreschoolList.dart';
import '../../../../generated/l10n.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // void _navigateToSearchPage(String searchQuery) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           Scaffold(
  //             body: Padding(
  //               padding: const EdgeInsets.only(top: 100),
  //               // Add additional space at the top
  //               child: SearchPage(searchQuery: searchQuery),
  //             ),
  //           ),
  //     ),
  //   );
  // }

  void _navigateToSearchPage(String searchQuery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(page: 1),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: MySearchBar(
                onSearch: (value) {
                  print('Home Search query: $value');
                  _navigateToSearchPage(value);
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                S.of(context).home_title,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const Center(
            child: PreschoolCard(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                S.of(context).home_sub_title,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          PreschoolListScreen(),
        ],
      ),
    ),
  );
}
}
