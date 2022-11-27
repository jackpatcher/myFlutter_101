import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:a001/screen.dart';
import 'package:a001/navBar.dart';
import 'package:a001/model.dart';
 

// ต่อ https://github.com/jackpatcher/myFlutter_101/blob/my1stResponsive1/lib/sys/_left/b_menu_select.dart

void main() =>
    runApp(DevicePreview(enabled: false, builder: (contex) =>  A001App()));

class A001App extends StatelessWidget {
   A001App({super.key});

    // private navigators
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
 

    final goRouter = GoRouter(
      initialLocation: '/a',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(tabs: tabs, child: child);
          },
          routes: [
            // Products
            GoRoute(
              path: '/a',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const RootScreen(label: 'A', detailsPath: '/a/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'A'),
                ),
              ],
            ),
            // Shopping Cart
            GoRoute(
              path: '/b',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const RootScreen(label: 'B', detailsPath: '/b/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    // return MaterialApp(
    //   title: "A001 App",
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   initialRoute: '/',
    //   routes: {
    //     '/':  (context) =>  HomeScreen( wg: const Page1() ),
    //     Page1.id :  (context) => HomeScreen( wg: const Page1() ) ,
    //     Page2.id:  (context) => HomeScreen( wg: const Page2() ) ,
    //     Page3.id:  (context) => HomeScreen( wg: const Page3() ),
    //     Page4.id:  (context) => HomeScreen( wg: const Page4() ) ,
    //   },
    // );

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
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
      for (int index = 0; index < tabs.length; index++) {
      myList.add( BottomNavigationBarItem (
        icon:   _selectedIndex == index ? tabs[index].activeIcon : tabs[index].icon,
        label: tabs[index].label,
        backgroundColor:  tabs[index].color, 
      )); 
    }
    return BottomNavigationBar(items: myList,
            currentIndex: _selectedIndex,
            onTap: (index) => changeTab(index),
            
            );
  }

  List<Widget> _genNavSideBarList() {
    List<Widget> myList = [];

    for (int index = 0; index < tabs.length; index++) {
      myList.add(Container(
        color:   Colors.white,
        child: ListTile(
          leading: _selectedIndex == index ? tabs[index].activeIcon : tabs[index].icon,
          title: Text(tabs[index].label),
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
    Navigator.of(context).pushReplacementNamed(tabs[index].route);

    // Navigator.pushNamed(context, tabs[index].route);
     //Navigator.pushNamed(context,tabs[index].route);
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
          tabs.length,(index) => NavigationRailDestination(
                icon: Tooltip(
                  message: tabs[index].label,
                  child: tabs[index].icon,
                ),
                label: Text(tabs[index].label),
                selectedIcon: tabs[index].activeIcon,
  
              )),
    );
  }
}




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
