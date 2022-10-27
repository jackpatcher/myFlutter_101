import 'package:dinsor_os/sys/config/cons/sys_lib_cons.dart';
import 'package:flutter/material.dart';

class UserProfileData {
  final ImageProvider image;
  final String name;
  final String jobDesk;

  const UserProfileData({
    required this.image,
    required this.name,
    required this.jobDesk,
  });
}

class UserProfile extends StatelessWidget {
  const UserProfile( {Key? key,  }) : super(key: key);

 
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              _buildImage(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildName(),
                    _buildJobdesk(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CircleAvatar(
      radius: 25,
      
    );
  }

  Widget _buildName() {
    return Text(
 "Text",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kFontColorPallets[0],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildJobdesk() {
    return Text(
      "Job",
      style: TextStyle(
        fontWeight: FontWeight.w300,
        color: kFontColorPallets[1],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
