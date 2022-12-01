import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'nav_menu_route.dart';
 

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
      Map<String, dynamic> myHome = {
      "size": 0.0,
      "isMobile": false,
      "isTablet": false,
      "isDesktop": false,
      "sizeOf_Mobile": 600,
      "sizeOf_Desktop": 1100,
    };
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Variable

    myHome["size"] = MediaQuery.of(context).size.width;

    myHome["isMobile"] =
        MediaQuery.of(context).size.width < myHome["sizeOf_Mobile"];
    myHome["isTablet"] =
        MediaQuery.of(context).size.width < myHome["sizeOf_Desktop"] &&
            MediaQuery.of(context).size.width >= myHome["sizeOf_Mobile"];
    myHome["isDesktop"] =
        MediaQuery.of(context).size.width >= myHome["sizeOf_Desktop"];
  
    myHome['indexedPage'] = IndexedPage.of(context);

    return Scaffold(
       
     // bottomNavigationBar: _genOldBtmNav(indexedPage),
      appBar: AppBar(
        title: const Text("โรงเรียน เดโม"),
        actions: [ IconButton(icon: const Icon(Icons.person), onPressed: () {}),],
      ),
      body: _mainLayout(),
      bottomNavigationBar: myHome["isMobile"]? _genMobileBottomNav():null,
    );
  }

  Widget _mainLayout() {
     
    return Row(children: [
     _genNavLayoutByScreenSize(),
      Expanded(child:  PageStackNavigator(stack:  myHome['indexedPage'].currentStack )),
    ]);


  }

   Widget _genNavLayoutByScreenSize(){
    Widget myWidget = Container();
    if (myHome["isTablet"]) {
      myWidget = _buildTabletNavigationRail();
    } else if (myHome["isDesktop"]) {
      myWidget = _buildDesktopSideBar();
    } else if (myHome["isMobile"]) {
      myWidget = Container();
    }

    return myWidget;
   }

     Widget _buildTabletNavigationRail() {
    var groupAligment = -1.0;
    var labelType = NavigationRailLabelType.selected;
 

    return NavigationRail(
      selectedIndex:  myHome['indexedPage'].index ,
      groupAlignment: groupAligment,
      onDestinationSelected: (int index) {   
          myHome['indexedPage'].index  = index;
      },
      labelType: labelType,
      leading: const SizedBox(),
      trailing: const SizedBox(),
      destinations: List<NavigationRailDestination>.generate(
          navItems.length,(index) => NavigationRailDestination(
                icon: Tooltip(
                  message: navItems[index].label,
                  child: Icon(navItems[index].icon),
                ),
                label: Text(navItems[index].label),
                selectedIcon: Icon(navItems[index].activeIcon),
  
              )),
    );
  }
    Widget _buildDesktopSideBar() {
    return Drawer(
      width: 200,
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: _genNavSideBarList(),
      ),
    );
  }

    Widget _genMobileBottomNav() {

     List   <BottomNavigationBarItem> myList = [];
      for (int index = 0; index < navItems.length; index++) {
      myList.add( BottomNavigationBarItem (
        
        icon:   myHome['indexedPage'].index == index? Icon(navItems[index].activeIcon) : Icon(navItems[index].icon),
        label: navItems[index].label,
        backgroundColor:  navItems[index].color, 
      
      )); 
    }
    return BottomNavigationBar(
      items: myList,
      currentIndex:  myHome['indexedPage'].index,      
      onTap: (int index) {
           myHome['indexedPage'].index = index;
        },
    );
  }

 

List<Widget> _genNavSideBarList() {
    List<Widget> myList = [];

    for (int index = 0; index < navItems.length; index++) {
      myList.add(Container(
        color:   Colors.white,
        child: ListTile(
          leading: myHome['indexedPage'].index== index ? Icon(navItems[index].activeIcon) : Icon(navItems[index].icon),
          title: Text(navItems[index].label),
          selected: myHome['indexedPage'].index   == index,
          selectedColor: Colors.blue,
          onTap: () {
            
            debugPrint("Tab $index");
            
            myHome['indexedPage'].index = index;
          },
        ),
      ));
    }

    myList.add(const Divider());

    return myList;
  }
}



