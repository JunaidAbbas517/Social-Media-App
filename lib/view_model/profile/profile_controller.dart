import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/res/compunents/text_input_field.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/services/session_manager.dart';

class ProfileController with ChangeNotifier {
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameFocus = FocusNode();
  final phoneFocus = FocusNode();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;
  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage();
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage();
      notifyListeners();
    }
  }

  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.camera_alt,
                    color: AppColors.primaryIconColor,
                  ),
                  title: Text(
                    'Camera',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.image,
                    color: AppColors.primaryIconColor,
                  ),
                  title: Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage() async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage ${SessionController().userId}');
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref.child(SessionController().userId.toString()).update({
      'profile': newUrl.toString(),
    }).then((value) {
      setLoading(false);
      Utils.toastMessage('Profile Updated');
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> showUserNameDialogBox(BuildContext context, String name) {
    userNameController.text = name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update username'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextField(
                  myController: userNameController,
                  focusNode: userNameFocus,
                  onFieldSubmittedValue: (value) {},
                  hint: 'username',
                  keyBoardType: TextInputType.text,
                  obscureText: false,
                  onValidator: (value) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'cancel',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: AppColors.alertColor),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ref
                              .child(SessionController().userId.toString())
                              .update({
                            'userName': userNameController.text.toString(),
                          }).then((value) {
                            userNameController.clear();
                            Utils.toastMessage('Update Successfully');
                          });
                        },
                        child: Text(
                          'ok',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showUserPhoneDialogBox(BuildContext context, String phone) {
    phoneController.text = phone;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update phone'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextField(
                  myController: phoneController,
                  focusNode: phoneFocus,
                  onFieldSubmittedValue: (value) {},
                  hint: 'Phone',
                  keyBoardType: TextInputType.text,
                  obscureText: false,
                  onValidator: (value) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'cancel',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: AppColors.alertColor),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ref
                              .child(SessionController().userId.toString())
                              .update({
                            'phone': phoneController.text.toString(),
                          }).then((value) {
                            phoneController.clear();
                            Utils.toastMessage('Update Successfully');
                          });
                        },
                        child: Text(
                          'ok',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
