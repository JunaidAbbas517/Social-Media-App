import 'package:flutter/material.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/view/dashboard/dashboard_screen.dart';
import 'package:social_media/view/forgot_password/forgot_password_screen.dart';
import 'package:social_media/view/signup/sign_up_screen.dart';

import '../../view/login/login_screen.dart';
import '../../view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.logInView:
        return MaterialPageRoute(builder: (_) => LogInScreen());
      case RouteName.signUpView:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
