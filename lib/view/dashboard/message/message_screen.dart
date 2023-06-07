import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/services/session_manager.dart';

import '../../../res/color.dart';

class MessageScreen extends StatefulWidget {
  final String name, email, profile, receiverId;
  const MessageScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.profile,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('chat');
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Text(index.toString());
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      controller: messageController,
                      onFieldSubmitted: (value) {},
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () {
                              sendMessage();
                            },
                            child: const CircleAvatar(
                              backgroundColor: AppColors.primaryIconColor,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        hintText: 'Enter Message',
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                                height: 0,
                                color: AppColors.primaryTextTextColor
                                    .withOpacity(0.8)),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.textFieldDefaultFocus,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.alertColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.textFieldDefaultBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.toString().isEmpty) {
      return Utils.toastMessage('Enter a message');
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiver': widget.receiverId.toString(),
        'type': 'text',
        'time': timeStamp.toString(),
      }).then(
        (value) => messageController.clear(),
      );
    }
  }
}
