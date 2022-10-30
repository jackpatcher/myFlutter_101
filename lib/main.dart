import 'package:flutter/material.dart';

void main() => runApp(const A001App());

class A001App extends StatelessWidget {
  const A001App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "A001 App",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

int _selectedIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.shortestSide < 768;
    return Scaffold(
      appBar: AppBar(
        title: const Text("โรงเรียน เดโม"),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: _mainLayout(isMobile),
    );
  }

  Widget _mainLayout(isMobile) {
    return Row(children: [
      isMobile ? _buildNavigationRail() : _buildSideBar(),
      Expanded(child: __buildHomeContentBody())
    ]);
  }

  Widget _buildSideBar() {
    return Container(
      color: Colors.white,
      width: 200,
      child: ListView.builder(
        itemCount: NavigationListItems.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(NavigationListItems[index].icon),
          title: Text(NavigationListItems[index].label),
        ),
      ),
    );
  }

  Widget __buildHomeContentBody() {
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
                icon: Tooltip(message: NavigationListItems[index].label,
                child:Icon(NavigationListItems[index].icon),),
                label:  Text(NavigationListItems[index].label) ,
          
                
                selectedIcon: Icon(NavigationListItems[index].selectedIcon),
              )),
    );
  }
}

class Navigationlist {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  Navigationlist(
      {required this.icon, required this.selectedIcon, required this.label});
}

List<Navigationlist> NavigationListItems = [
  Navigationlist(
      icon: Icons.home_outlined, selectedIcon: Icons.home, label: "หน้าแรก"),
  Navigationlist(
      icon: Icons.favorite_border, selectedIcon: Icons.favorite, label: "บันทึก"),
  Navigationlist(
      icon: Icons.bookmark_border, selectedIcon: Icons.book, label: "ข้อมูล"),
  Navigationlist(
      icon: Icons.star_border, selectedIcon: Icons.star, label: "รายงาน"),
];
