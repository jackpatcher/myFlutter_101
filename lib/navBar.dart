import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:a001/model.dart';


class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar(
      {Key? key, required this.child, required this.tabs})
      : super(key: key);
  final Widget child;
  final List<NavigationList> tabs;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _locationToTabIndex(String location) {
    final index =
        widget.tabs.indexWhere((t) => location.startsWith(t.route));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  void _onItemTapped(BuildContext context, int tabIndex) {
    // Only navigate if the tab index has changed
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _genMobileBottomNav(),
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  List <BottomNavigationBarItem>  _genMobileBottomNav() {
     List   <BottomNavigationBarItem> myList = [];
      for (int index = 0; index < widget.tabs.length; index++) {
      myList.add( BottomNavigationBarItem (
        icon:  _currentIndex == index? widget.tabs[index].activeIcon:widget.tabs[index].icon,
        label: widget.tabs[index].label,
        backgroundColor:  widget.tabs[index].color, 
      )); 
    }
    return  myList;
  }


}


 