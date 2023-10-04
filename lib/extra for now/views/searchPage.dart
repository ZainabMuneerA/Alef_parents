import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required String searchQuery}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: MySearchBar(
                onSearch: (String value) {
                  print(value);
                },
              ),
            ),
            SizedBox(width: 4),
            filterButton(),
          ],
        ),
        Expanded(
          child: Center(
            child: Text('Search results will be displayed here.'),
          ),
        ),
      ],
    );
  }

  Widget filterButton() {
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {
        // Handle filter button press
        print('Filter button pressed');
      },
    );
  }
}



//search bar class
class MySearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  MySearchBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final value = _searchController.text;
    widget.onSearch(value);
  }

  void _handleCancel() {
    _searchController.clear();
    _searchFocusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      // Refresh the widget state when the focus state changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTextFieldFocused = _searchFocusNode.hasFocus;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(context, 'search_hint'),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Perform search operation based on the value entered in the TextField
                // You can define your own search logic here
                print('Search query: $value');
              },
              onEditingComplete: _handleSearch,
            ),
          ),
          if (isTextFieldFocused)
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: _handleCancel,
            ),
        ],
      ),
    );
  }
}