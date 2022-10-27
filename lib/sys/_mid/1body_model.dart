 
part of sys_mid;

 

class SysM1BodyCardData {
  final String label;
  final int numberRegist;
  final int total;
  final IconData  icon;

  const SysM1BodyCardData({
    required this.label,
    required this.numberRegist,
    required this.total,   

    required this.icon, 
  });

 


}

List<SysM1BodyCardData> getCards()=>
  const[
    SysM1BodyCardData(
      label: "นักเรียน",
      numberRegist: 1050,
      total: 1500,
      icon: Icons.person,
    ),
    SysM1BodyCardData(
      label: "บุคลากร",
      numberRegist:  20 ,
      total:  56 ,
      icon: Icons.supervisor_account,
    ),
    SysM1BodyCardData(
      label: "ผู้ปกครอง",
      numberRegist:  55 ,
      total:  1500 ,
      icon: Icons.escalator_warning,
    ),
    SysM1BodyCardData(
      label: "ผู้ดูแลระบบ",
      numberRegist:  20 ,
      total:  26 ,
      icon: Icons.lock_person,
    )
  ];


 

    
 