import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/view/dashboard/message/message_screen.dart';
import 'package:social_media/view_model/services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User List'),
        elevation: 1,
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            if (SessionController().userId.toString() ==
                snapshot.child('uid').value.toString()) {
              return Container();
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MessageScreen(
                            name: snapshot.child('userName').value.toString(),
                            profile: snapshot.child('profile').value.toString(),
                            email: snapshot.child('email').value.toString(),
                            receiverId: snapshot.child('uid').value.toString(),
                          ),
                          withNavBar: false,
                        );
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryTextTextColor,
                          ),
                        ),
                        child: snapshot.child('profile').value.toString() == ''
                            ? Icon(Icons.person)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshot
                                      .child('profile')
                                      .value
                                      .toString()),
                                ),
                              ),
                      ),
                      title: Text(
                        snapshot
                            .child(
                              'userName',
                            )
                            .value
                            .toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          snapshot.child('email').value.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
