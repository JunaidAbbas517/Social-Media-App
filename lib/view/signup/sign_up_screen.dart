import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/compunents/rounded_button.dart';
import 'package:social_media/res/compunents/text_input_field.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/signup/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();

  final passwordController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final nameController = TextEditingController();

  final nameFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_) => SignUpController(),
            child: Consumer<SignUpController>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Text(
                        'Register your account',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.06, bottom: height * 0.01),
                            child: Column(
                              children: [
                                InputTextField(
                                  myController: nameController,
                                  focusNode: nameFocusNode,
                                  onFieldSubmittedValue: (value) {
                                    Utils.fieldFocus(
                                        context, nameFocusNode, emailFocusNode);
                                  },
                                  hint: 'name',
                                  keyBoardType: TextInputType.text,
                                  obscureText: false,
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter user Name'
                                        : null;
                                  },
                                ),
                                InputTextField(
                                  myController: emailController,
                                  focusNode: emailFocusNode,
                                  onFieldSubmittedValue: (value) {
                                    Utils.fieldFocus(context, emailFocusNode,
                                        passwordFocusNode);
                                  },
                                  hint: 'email',
                                  keyBoardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter email address'
                                        : null;
                                  },
                                ),
                                InputTextField(
                                  myController: passwordController,
                                  focusNode: passwordFocusNode,
                                  onFieldSubmittedValue: (value) {},
                                  hint: 'password',
                                  keyBoardType: TextInputType.emailAddress,
                                  obscureText: true,
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter password'
                                        : null;
                                  },
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        title: 'SignUp',
                        isLoading: provider.isLoading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.signUp(
                              context,
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.logInView);
                        },
                        child: Text.rich(TextSpan(
                            text: "Already have an account?  ",
                            style: Theme.of(context).textTheme.subtitle2,
                            children: [
                              TextSpan(
                                text: 'Log In',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                              ),
                            ])),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
