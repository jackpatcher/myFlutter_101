import 'package:dinsor_os/sys/config/cons/sys_lib_cons.dart';
import 'package:dinsor_os/sys/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: const Offset(25, -35),
                 child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Transform.translate(
            offset: const Offset(-1,10 ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(.2),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class ViewPaperTopCorner extends StatelessWidget {
  const ViewPaperTopCorner({required this.child, Key? key})
      : super(key: key);
        final Widget child;
        static const double borderPage = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all( .0),
      color: AppTheme.initTheme.primaryColor,
      child: Column(
        children: [
          // const SizedBox(height: kSpacing),
          
          Container(
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(borderPage)),

              color: Colors.white,
            ),
            child: child,
            )
        ]
        )
    );
            
  }
}