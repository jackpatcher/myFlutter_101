part of dashboard;

class _BottomNav extends StatefulWidget {
  const _BottomNav({Key? key}) : super(key: key);

  @override
  State<_BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<_BottomNav> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      items:  [
        BottomNavigationBarItem(
          activeIcon: const Icon(EvaIcons.home),
          icon: const Icon(EvaIcons.homeOutline),
          label: "Home",
          backgroundColor: Colors.amber[900],
        ),
        const BottomNavigationBarItem(
          activeIcon: Icon(EvaIcons.bell),
          icon: Icon(EvaIcons.bellOutline),
          label: "AppStore",
           backgroundColor: Colors.blue,
        ),
        const BottomNavigationBarItem(
          activeIcon: Icon(EvaIcons.checkmarkCircle2),
          icon: Icon(EvaIcons.checkmarkCircle),
          label: "Task",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          activeIcon: const Icon(EvaIcons.settings),
          icon: const Icon(EvaIcons.settingsOutline),
          label: "Settings",
           backgroundColor: Colors.deepPurple.shade700,
        ),
      ],
      selectedItemColor: sys_getHeaderColor,
      unselectedItemColor: Colors.brown.withOpacity(.4),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      onTap: (value) {
        setState(() {
          index = value;
        });
      },
    );
  }
}
