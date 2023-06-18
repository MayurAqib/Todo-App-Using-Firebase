import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app_using_rest_api/colors/colors.dart';
import 'package:to_do_app_using_rest_api/pages/forgot_page.dart';
import 'package:to_do_app_using_rest_api/utils/my_button.dart';
import 'package:to_do_app_using_rest_api/utils/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final void Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // login Function

  void login() async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
            return AlertDialog(
              title: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkbackground,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.network(
                  'https://cdn-icons-png.flaticon.com/128/10164/10164387.png',
                  height: 120,
                  color: textColor,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'WELCOME BACK !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: textColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                ),
                MyTextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: obscureText,
                    icon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: darkbackground,
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            )),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: themeColor, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(buttonText: 'Login', onTap: login),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?  '),
                    TextButton(
                      onPressed: widget.onTap,
                      child: Text(
                        'REGISTER!',
                        style: GoogleFonts.bebasNeue(
                            color: designColor, fontSize: 17, letterSpacing: 1),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
