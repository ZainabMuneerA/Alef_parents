import 'package:alef_parents/testPayment.dart';
import 'package:flutter/material.dart';

class FormNavigator extends StatefulWidget {
  @override
  _FormNavigatorState createState() => _FormNavigatorState();
}

class _FormNavigatorState extends State<FormNavigator> {
    late PageController _pageController;

    @override

    
void initState() {
        super.initState();
        _pageController = PageController(initialPage: 0);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Navigation'),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          FormPage(title: 'Form 1'),
          FormPage(title: 'Form 2'),
          FormPage(title: 'Form 3'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageController.page?.round() ?? 0,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: 'Form 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: 'Form 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: 'Form 3',
          ),
        ],
      ),
    );
  }
}
