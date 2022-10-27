part of sys_mid;

class SysM2Body extends StatelessWidget {
  const SysM2Body({ 
    Key? key,
  }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 200,
       height: 200,color:Colors.amberAccent,
    );
  }
}

class SysMBcontentList {
  final Icon icon;
  final String label;
  final String jobDesk;
  final DateTime? editDate;
  final String? assignTo;

  const SysMBcontentList({
    required this.icon,
    required this.label,
    required this.jobDesk,
    this.editDate,
    this.assignTo,
  });
}

class ListTaskAssigned extends StatelessWidget {
  const ListTaskAssigned({
    required this.data,
    required this.onPressed,
    required this.onPressedAssign,
    required this.onPressedMember,
    Key? key,
  }) : super(key: key);

  final SysMBcontentList data;
  final Function() onPressed;
  final Function()? onPressedAssign;
  final Function()? onPressedMember;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      hoverColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      leading: _buildIcon(),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: _buildAssign(),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(.1),
      ),
      child: data.icon,
    );
  }

  Widget _buildTitle() {
    return Text(
      data.label,
      style: const TextStyle(fontWeight: FontWeight.w200),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    String edit = "";

    if (data.editDate != null) {
      edit = " \u2022 edited ${timeago.format(data.editDate!)}";
    }

    return Text(
      data.jobDesk + edit,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAssign() {
    return (data.assignTo != null)
        ? InkWell(
            onTap: onPressedMember,
            borderRadius: BorderRadius.circular(22),
            child: Tooltip(
              message: data.assignTo!,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.orange.withOpacity(.2),
                child: Text(
                  data.assignTo!.getInitialName(2).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        : DottedBorder(
            color: kFontColorPallets[1],
            strokeWidth: .3,
            strokeCap: StrokeCap.round,
            borderType: BorderType.Circle,
            child: IconButton(
              onPressed: onPressedAssign,
              color: kFontColorPallets[1],
              iconSize: 15,
              icon: const Icon(EvaIcons.plus),
              splashRadius: 24,
              tooltip: "assign",
            ),
          );
  }
}


