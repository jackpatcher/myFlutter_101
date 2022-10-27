library dashboard;

import 'package:dinsor_os/sys/config/cons/sys_lib_cons.dart';
import 'package:dinsor_os/sys/config/themes/app_theme.dart';

 
 
import 'package:dinsor_os/sys/comp/list_task_date.dart';
import 'package:dinsor_os/sys/comp/responsive_builder.dart';
//import 'package:dinsor_os/sys/comp/search_field.dart';
import 'package:dinsor_os/sys/_left/b_menu_select.dart';
import 'package:dinsor_os/sys/comp/simple_selection_button.dart';
import 'package:dinsor_os/sys/comp/simple_user_profile.dart';
import 'package:dinsor_os/sys/comp/task_progress.dart';
import 'package:dinsor_os/sys/comp/user_profile.dart';
import 'package:dinsor_os/sys/sys_viewmodels/sys_views.dart';
// import 'package:percent_indicator/percent_indicator.dart';
//import 'package:dinsor_os/sys/view_model/utils/helpers/app_helpers.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// model
 

 
import '_mid/mid_lib.dart';
import '_right/right_lib.dart';

// binding
part 'comp/binding.dart';

// controller
part 'package:dinsor_os/sys/dashboard_controller.dart';

// component
part 'comp/bottom_nav.dart';
part 'appbar.dart';

// layout Left
part '_left/a_menu.dart';
part '_left/b_menu.dart';
part '_left/b_member.dart';
// layout  
part '_mid/mid.dart';
part '_right/right.dart';

 

 

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: MyAppBar()),
      key: controller.scafoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: leftSection(context)),
              ),
            ),
      bottomNavigationBar: (ResponsiveBuilder.isDesktop(context) || kIsWeb)
          ? null
          : const _BottomNav(),
      body: SafeArea(
        child: ResponsiveBuilder(
          
          // Mobile
          mobileBuilder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SysMidSection(
                      //onPressedMenu: () => controller.openDrawer(),
                      ),
                  SysRightSection(),
                ],
              ),
            );
          },

          // Tablet
          tabletBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 800 ? 8 : 7,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  const [
                       SysMidSection(
                         // onPressedMenu: () => controller.onClose(),
                        ),
                        SysRightSection(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },

          // Desktop
          desktopBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 3 : 4,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: leftSection(context),
                  ),
                ),
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 10 : 9,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: const SysMidSection(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const VerticalDivider(),
                ),
                Flexible(
                  flex: 4,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: SysRightSection(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// ซ้าย
  Widget leftSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const UserProfile(),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: HeaderText("LEFT App Menu"),
          ),
          const SizedBox(height: kSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _MainMenu(onSelected: (int index, SelectionButtonData value) {  }, ),
          ),
          const Divider(
            indent: 20,
            thickness: 1,
            endIndent: 20,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: HeaderText("LEFT Content"),
          ),
          const SizedBox(height: kSpacing),
          _Member(member: controller.member),
          const SizedBox(height: kSpacing),
          _TaskMenu(
           
          ),
          const SizedBox(height: kSpacing),
          Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Text(
              "Copyright 2022",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

 
}
