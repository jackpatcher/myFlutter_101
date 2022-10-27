part of sys_mid;

class  SysM2head extends StatelessWidget {
  const SysM2head({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HeaderText("M2header"),
        const Spacer(),
        _buildArchive(),
        const SizedBox(width: 10),
        _buildAddNewButton(),
      ],
    );
  }



  Widget _buildArchive() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey[850], backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: const Text("Archive"),
    );
  }

  Widget _buildAddNewButton() {
    return ElevatedButton.icon(
      icon: const Icon(
        EvaIcons.plus,
        size: 16,
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      label: const Text("New"),
    );
  }



}
