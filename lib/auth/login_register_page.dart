import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/pages/login_page.dart';
import 'package:to_do_app_using_rest_api/pages/register_page.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool showLoginPage = true;
  togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return RegisterPage(
        onTap: togglePage,
      );
    }
  }
}
