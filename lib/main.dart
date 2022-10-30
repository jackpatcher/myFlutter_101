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
        '/': ((context) => const HomeScreen()),
        '/page1': ((context) => Page1()),
        '/page2': ((context) => Page2()),
        '/page3': ((context) => Page3()),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].

  int _selectedIndex = 0;
  List<bool> isHilight = [false, false, false, false];

   Map<String,dynamic> a =  {"size":0.1};
    
    
 
  

  @override
  Widget build(BuildContext context) {
    isHilight[_selectedIndex] = true;

    setState(() {
       a["size"] = MediaQuery.of(context).size.width;
      
    });
    

    final isMobile = MediaQuery.of(context).size.width < 900;
    //final isTablet = MediaQuery.of(context).size.shortestSide < 768;
    return Scaffold(
      appBar: AppBar(
        title: const Text("โรงเรียน เดโม"),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: _mainLayout(isMobile,a),
    );
  }

  Widget _mainLayout(isMobile,a) {
    return Row(children: [
      isMobile ? _buildNavigationRail() : _buildSideBar(),
      Expanded(child: _buildHomeContentBody(a))
    ]);
  }

  Widget _buildSideBar() {
    return Drawer(
      width: 200,
      child: ListView.builder(
        itemCount: NavigationListItems.length,
        itemBuilder: (context, index) => GestureDetector(
          child: Container(
            color: isHilight[index] ? Colors.blue : Colors.white,
            child: ListTile(
              leading: Icon(NavigationListItems[index].icon),
              title: Text(NavigationListItems[index].label),
              selected: _selectedIndex == index,
              selectedColor: Colors.white,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });

                isHilight.asMap().entries.map(
                  (e) {
                    if (e.key == index) {
                      setState(() {
                        isHilight[e.key] = true;
                      });
                    } else {
                      setState(() {
                      isHilight[e.key] = false;
                       });

                    }
                  },
                );

                
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget  _buildHomeContentBody(a) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 160.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('A001 การมาโรงเรียน', textAlign: TextAlign.left),
            ),
            background: FlutterLogo(),
          ),
        ),
         SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
            child: Center(
              child: Text(' ความกว้าง ${a ['size']}' ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
            child: Center(
              child: Text('ข้อมูลคั่นบางๆ'),
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
            childCount: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationRail() {
    var groupAligment = -1.0;
    var labelType = NavigationRailLabelType.selected;
    var showLeading = false;
    var showTrailing = false;

    return NavigationRail(
      selectedIndex: _selectedIndex,
      groupAlignment: groupAligment,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: labelType,
      leading: showLeading
          ? FloatingActionButton(
              elevation: 0,
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
      trailing: showTrailing
          ? IconButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.more_horiz_rounded),
            )
          : const SizedBox(),
      destinations: List<NavigationRailDestination>.generate(
          NavigationListItems.length,
          (index) => NavigationRailDestination(
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

  Navigationlist(
      {required this.route,
      required this.icon,
      required this.activeIcon,
      required this.label});
}

List<Navigationlist> NavigationListItems = [
  Navigationlist(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: "หน้าแรก",
      route: "/"),
  Navigationlist(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: "บันทึก",
      route: "/page1"),
  Navigationlist(
      icon: Icons.bookmark_border,
      activeIcon: Icons.book,
      label: "ข้อมูล",
      route: "/page2"),
  Navigationlist(
      icon: Icons.star_border,
      activeIcon: Icons.star,
      label: "รายงาน",
      route: "/page3"),
];

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("page 1"),
        ),
        body: Text("page 1"));
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("page 2"),
        ),
        body: Text("page 2"));
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("page 3"),
        ),
        body: Text("page 3"));
  }
}
