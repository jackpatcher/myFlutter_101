part of sys_right;

 
 
class SysR1BodyTaskData {
  final String label;
  final int numberRegist;
  final int total;
  final IconData  icon;

  const SysR1BodyTaskData({
    required this.label,
    required this.numberRegist,
    required this.total,   
    required this.icon, 
  });

 


}

List<SysR1BodyTaskData> getTasks()=>
  const[
    SysR1BodyTaskData(
      label: "นักเรียน",
      numberRegist: 1050,
      total: 1500,
      icon: Icons.person,
    ),
    SysR1BodyTaskData(
      label: "บุคลากร",
      numberRegist:  20 ,
      total:  56 ,
      icon: Icons.supervisor_account,
    ),
    SysR1BodyTaskData(
      label: "ผู้ปกครอง",
      numberRegist:  55 ,
      total:  1500 ,
      icon: Icons.escalator_warning,
    ),
    SysR1BodyTaskData(
      label: "ผู้ดูแลระบบ",
      numberRegist:  20 ,
      total:  26 ,
      icon: Icons.lock_person,
    )
  ];


