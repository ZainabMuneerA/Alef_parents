import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../app_theme.dart';

class AppNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _AppNavigationBarState createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                text: S.of(context).home,
                icon: Icons.home,
                selected: widget.selectedIndex == 0,
                onPressed: () {
                  widget.onItemTapped(0);
                },
              ),
              IconBottomBar(
                text: S.of(context).search,
                icon: Icons.search_outlined,
                selected: widget.selectedIndex == 1,
                onPressed: () {
                  widget.onItemTapped(1);
                },
              ),
              IconBottomBar(
                text: S.of(context).profile,
                icon: Icons.person,
                selected: widget.selectedIndex == 2,
                onPressed: () {
                  widget.onItemTapped(2);
                },
              ),
              // Add the remaining bottom bar icons here
               IconBottomBar(
                text: S.of(context).preschool,
                icon: Icons.holiday_village,
                selected: widget.selectedIndex == 3,
                onPressed: () {
                  widget.onItemTapped(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar({
    Key? key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 30,
            color: selected ? secondaryColor : Colors.black54,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            height: .1,
            color: selected ? secondaryColor : Colors.grey.withOpacity(.75),
          ),
        )
      ],
    );
  }
}
