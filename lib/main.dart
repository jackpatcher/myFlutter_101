import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

// ต่อ https://github.com/jackpatcher/myFlutter_101/blob/my1stResponsive1/lib/sys/_left/b_menu_select.dart

void main() =>
    runApp(DevicePreview(enabled: false, builder: (contex) => const A001App()));

class A001App extends StatelessWidget {
  const A001App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "A001 App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/':  (context) =>  HomeScreen( wg: const Page1() ),
        Page1.id :  (context) => HomeScreen( wg: const Page1() ) ,
        Page2.id:  (context) => HomeScreen( wg: const Page2() ) ,
        Page3.id:  (context) => HomeScreen( wg: const Page3() ),
        Page4.id:  (context) => HomeScreen( wg: const Page4() ) ,
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  Widget wg;

    HomeScreen({
    super.key,
    required this.wg,
    });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   
   
  
// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].

  //List<bool> isHilight = [false, false, false, false];



  List <Widget> _pages = <Widget>[
    const Page1(),
    const Page2(),
    const Page3(),
     const Text('Index 3 : Home',style: TextStyle(fontSize: 30),),
  ];

  Map<String, dynamic> myLocalList = {
    "size": 0.0,
    "isMobile": false,
    "isTablet": false,
    "isDesktop": false,
    "sizeOf_Mobile": 600,
    "sizeOf_Desktop": 1100,
  };
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //isHilight[_selectedIndex] = true;

    myLocalList["size"] = MediaQuery.of(context).size.width;

    myLocalList["isMobile"] =
        MediaQuery.of(context).size.width < myLocalList["sizeOf_Mobile"];
    myLocalList["isTablet"] =
        MediaQuery.of(context).size.width < myLocalList["sizeOf_Desktop"] &&
            MediaQuery.of(context).size.width >= myLocalList["sizeOf_Mobile"];
    myLocalList["isDesktop"] =
        MediaQuery.of(context).size.width >= myLocalList["sizeOf_Desktop"];

    //final isTablet = MediaQuery.of(context).size.shortestSide < 768;
    return Scaffold(
      appBar: AppBar(
        title: const Text("โรงเรียน เดโม"),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: _mainLayout(myLocalList ), 
      bottomNavigationBar:   _genMobileBottomNav() ,
    );
  }

  Widget _mainLayout(myLocalList ) {
    return Row(children: [
      _genNavLayoutByScreenSize(),
      Expanded(child: _buildHomeContentBody( widget.wg)),
    ]);
  }

  Widget _genNavLayoutByScreenSize() {
    Widget myWidget = Container();
    if (myLocalList["isTablet"]) {
      myWidget = _buildTabletNavigationRail();
    } else if (myLocalList["isDesktop"]) {
      myWidget = _buildDesktopSideBar();
    } else if (myLocalList["isMobile"]) {
      myWidget = Container();
    }

    return myWidget;
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
      for (int index = 0; index < NavigationListItems.length; index++) {
      myList.add( BottomNavigationBarItem (
        icon:   _selectedIndex == index ? Icon(NavigationListItems[index].activeIcon) : Icon(NavigationListItems[index].icon),
        label: NavigationListItems[index].label,
        backgroundColor:  NavigationListItems[index].color, 
      )); 
    }
    return BottomNavigationBar(items: myList,
            currentIndex: _selectedIndex,
            onTap: (index) => changeTab(index),
            
            );
  }

  List<Widget> _genNavSideBarList() {
    List<Widget> myList = [];

    for (int index = 0; index < NavigationListItems.length; index++) {
      myList.add(Container(
        color:   Colors.white,
        child: ListTile(
          leading: _selectedIndex == index ? Icon(NavigationListItems[index].activeIcon) : Icon(NavigationListItems[index].icon),
          title: Text(NavigationListItems[index].label),
          selected: _selectedIndex == index,
          selectedColor: Colors.blue,
          onTap: () {
            
            debugPrint("Tab $index");
            
            setState(() {
              _selectedIndex = index;
            });

          },
        ),
      ));
    }

    myList.add(const Divider());

    return myList;
  }

  //https://stackoverflow.com/questions/50961158/how-to-programmatically-select-bottomnavigationbar-tab-in-flutter-instead-of-bui
  void changeTab(int index) {
    Navigator.of(context).pushReplacementNamed(NavigationListItems[index].route);

    // Navigator.pushNamed(context, NavigationListItems[index].route);
     //Navigator.pushNamed(context,NavigationListItems[index].route);
     //Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Page1()));
    
    setState(() {
      _selectedIndex = index;
    });
  }

 
 Widget sampleContent(){
  return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
            child: Center(
              child: Text(' ความกว้าง ${myLocalList['size']}'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
            child: Center(
              child: Text(
                  ' Mobile: ${myLocalList['isMobile']} Tablet:${myLocalList['isTablet']} Desktop : ${myLocalList['isDesktop']}'),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 50,
                child: Center(
                  child: Text('$index', textScaleFactor: 1),
                ),
              );
            },
            childCount: 50,
          ),
        ),
      ],
    );
 }

 


Widget _buildHomeContentBody(contentWidget) {
    return contentWidget;
}


  Widget _buildTabletNavigationRail() {
    var groupAligment = -1.0;
    var labelType = NavigationRailLabelType.selected;
 

    return NavigationRail(
      selectedIndex: _selectedIndex,
      groupAlignment: groupAligment,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });

      },
      labelType: labelType,
      leading: const SizedBox(),
      trailing: const SizedBox(),
      destinations: List<NavigationRailDestination>.generate(
          NavigationListItems.length,(index) => NavigationRailDestination(
                icon: Tooltip(
                  message: NavigationListItems[index].label,
                  child: Icon(NavigationListItems[index].icon),
                ),
                label: Text(NavigationListItems[index].label),
                selectedIcon: Icon(NavigationListItems[index].activeIcon),
  
              )),
    );
  }
}

class Navigationlist {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final Color color;

  Navigationlist(
      {required this.route,
      required this.icon,
      required this.activeIcon,
      required this.label, 
      required this.color,
      });
}

// ignore: non_constant_identifier_names
List<Navigationlist> NavigationListItems = [
  Navigationlist(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: "หน้าแรก",
      route: "/page1",
      color:Colors.pink),
  Navigationlist(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: "บันทึก",
      route: "/page2",
      color:Colors.blue), 
  Navigationlist(
      icon: Icons.bookmark_border,
      activeIcon: Icons.book,
      label: "ข้อมูล",
      route: "/page3",
      color:Colors.green), 
  Navigationlist(
      icon: Icons.star_border,
      activeIcon: Icons.star,
      label: "รายงาน",
      route: "/page4",
      color:Colors.grey), 
];

class Page1 extends StatelessWidget {
  const Page1({super.key});

  static String id = "/page1";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("page 1"),
        ),
        body: const Text("page 1"));
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  static String id = "/page2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("page 2"),
        ),
        body: const Text("page 2"));
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});
  static String id = "/page3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("page 3"),
        ),
        body: const Text("page 3"));
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});
  static String id = "/page4";

  



  @override
  Widget build(BuildContext context) {
      //  setState(() {
      //      _selectedIndex = 4;
      //   });

    return Scaffold(
        appBar: AppBar(
          title: const Text("page 4"),
        ),
        body: const Text("page 4"));
  }
}
