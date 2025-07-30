import 'package:flutter/material.dart';
import 'package:task_management/data/models/users_model.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/screens/Update_profile_screen.dart';
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
    final user = AuthController.userModel;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: _onTapProfile_screen,
        child: Row(
          children: [
            CircleAvatar(
            ),
            const SizedBox(width: 16,),
            if(user!=null)...[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                  ],
                ),
              ),
            ]else...[
              const Expanded(
                  child:Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                    color: Colors.white),))
            ],
        IconButton(onPressed: _onTapLogOutButton, icon: Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapLogOutButton()
  async {
    await AuthController.clearData();
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }


  void _onTapProfile_screen()
  {
    if(ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name)
      {
        Navigator.pushNamed(context, UpdateProfileScreen.name);
      }

  }



}
