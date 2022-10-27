// ignore_for_file: file_names

part of sys_mid;

class SysM1head extends StatelessWidget {
  const SysM1head({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  const [
        HeaderText("M1h admin dashboards"),
        Spacer(),
        SizedBox(width: 10),
        SizedBox(width: kSpacing / 2),
        SizedBox(
       
          child: Icon(Icons.search),
        ),
      ],
    );
  }
}
