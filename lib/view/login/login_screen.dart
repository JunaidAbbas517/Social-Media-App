import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/compunents/rounded_button.dart';
import 'package:social_media/res/compunents/text_input_field.dart';
import 'package:social_media/view_model/login/login_controller.dart';

import '../../utils/routes/route_name.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();

  final passwordController = TextEditingController();

  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.07,
                ),
                Text(
                  'Welcome to the App',
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
                            myController: emailController,
                            focusNode: emailFocusNode,
                            onFieldSubmittedValue: (value) {},
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
                                  ? 'Enter email address'
                                  : null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.forgotPasswordScreen);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot password',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ChangeNotifierProvider(
                  create: (_) => LogInController(),
                  child: Consumer<LogInController>(
                    builder: (context, provider, child) {
                      return RoundedButton(
                        title: 'login',
                        isLoading: provider.isLoading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.logIn(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signUpView);
                  },
                  child: Text.rich(TextSpan(
                      text: "Don't have an account?  ",
                      style: Theme.of(context).textTheme.subtitle2,
                      children: [
                        TextSpan(
                          text: 'Sign Up',
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
          ),
        ),
      ),
    );
  }
}
