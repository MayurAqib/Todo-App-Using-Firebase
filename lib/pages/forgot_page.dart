import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/colors/colors.dart';
import 'package:to_do_app_using_rest_api/utils/my_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final resetEmailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    resetEmailController.dispose();
  }

  void resetPassword() async {
    if (resetEmailController.text.trim().isEmpty ||
        !resetEmailController.text.contains('@')) {
      return;
    }
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetEmailController.text.trim());

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        return showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
              return AlertDialog(
                title: Text(e.message.toString()),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
              return const AlertDialog(
                title: Text('Reset password link sent'),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkbackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'R E S E T  P A S S W O R D !',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Enter your email and we will send you a password reset link to your email',
              ),
              const SizedBox(height: 10),
              MyTextfield(
                controller: resetEmailController,
                hintText: 'Email',
              ),
              Center(
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(textColor)),
                  onPressed: resetPassword,
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: darkbackground),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
