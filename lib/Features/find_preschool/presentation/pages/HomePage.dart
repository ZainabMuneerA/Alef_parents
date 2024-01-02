import 'package:flutter/material.dart';

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

  void _navigateToSearchPage(String searchQuery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(page: 1, searchString: searchQuery,),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0,15,15,15),
              child: Center(
                child: MySearchBar(
                  onSearch: (value) {
                    _navigateToSearchPage(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  S.of(context).home_title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
             Center(
              child: PreschoolCardScreen(),
              // PreschoolCard(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  S.of(context).home_sub_title,
                  style: const TextStyle(
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
    ),
  );
}
}
