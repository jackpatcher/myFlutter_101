part of dashboard;

class DashboardController extends GetxController {
  final scafoldKey = GlobalKey<ScaffoldState>();

  final dataProfil = const UserProfileData(
    image: AssetImage(ImageRasterPath.man),
    name: "Geradt ",
    jobDesk: "Project Manager",
  );

  final member = ["Avril Kimberly", "Michael Greg"];
 




 

  void openDrawer() {
    if (scafoldKey.currentState != null) {
      scafoldKey.currentState!.openDrawer();
    }
  }
}
