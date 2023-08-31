import 'package:flutter/material.dart';
import 'package:greenhousenrru/autocontrol.dart';
import 'package:greenhousenrru/controlscreen.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedindex = 0;
  List<Widget> _widgetOptions = [
    DesignPage(),
    autocontrol(),
  ];

  void _onitemTap(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_motion),
            label: 'Automation',
          ),
        ],
        currentIndex: _selectedindex,
        onTap: _onitemTap,
      ),
    );
  }
}
