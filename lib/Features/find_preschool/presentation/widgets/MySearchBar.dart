import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class MySearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  MySearchBar({
    Key? key,
    required this.onSearch,  TextEditingController? searchController,
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

    // Define custom InputBorder
    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.transparent, // Set the color to transparent
        width: 0, // Set the width to 0
      ),
      borderRadius: BorderRadius.circular(18),
    );

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
                hintText:
                    S.of(context).search_hint, 
                border: InputBorder.none,
                focusedBorder: focusedBorder,
              ),
              onChanged: (value) {
                
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
