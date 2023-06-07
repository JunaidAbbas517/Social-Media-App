import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_media/view/dashboard/profile/profile.dart';
import 'package:social_media/view/user/user_list_screen.dart';

import '../../res/color.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final persistentController = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      Center(
        child: Text(
          'Home',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      Text('Chat'),
      Text('Add'),
      UserListScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.home,
            color: Colors.grey.shade50,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: AppColors.primaryIconColor,
          icon: Icon(Icons.message),
          inactiveIcon: Icon(
            Icons.message,
            color: Colors.grey.shade50,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: AppColors.primaryIconColor,
          icon: Icon(Icons.add),
          inactiveIcon: Icon(
            Icons.add,
            color: Colors.grey.shade50,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: AppColors.primaryIconColor,
          icon: Icon(Icons.supervised_user_circle),
          inactiveIcon: Icon(
            Icons.supervised_user_circle,
            color: Colors.grey.shade50,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: AppColors.primaryIconColor,
          icon: Icon(Icons.person),
          inactiveIcon: Icon(
            Icons.person,
            color: Colors.grey.shade50,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      controller: persistentController,
      items: _navBarItem(),
      backgroundColor: AppColors.secondaryTextColor,
      navBarStyle: NavBarStyle.style15,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.red,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
// Scaffold(
// appBar: AppBar(
// title: Text(SessionController().userId.toString()),
// actions: [
// IconButton(
// onPressed: () {
// auth.signOut().then((value) {
// Navigator.pushNamed(context, RouteName.logInView);
// });
// },
// icon: const Icon(Icons.exit_to_app))
// ],
// ),
// )
