import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
class Task_manager_AppBar extends StatefulWidget implements PreferredSizeWidget {

  Task_manager_AppBar({
    super.key,
  });

  @override
  State<Task_manager_AppBar> createState() => _Task_manager_AppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _Task_manager_AppBarState extends State<Task_manager_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(
          ),
          const SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rimon islam",style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
                Text('Rimon1234@gmail.com',style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
              ],
            ),
          ),
      IconButton(onPressed: _onTapLogOutButton, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }

  void _onTapLogOutButton()
  {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }


}
