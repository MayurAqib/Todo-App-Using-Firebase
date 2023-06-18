import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/utils/my_button.dart';
import 'package:to_do_app_using_rest_api/utils/show_dialog.dart';

import '../colors/colors.dart';
import '../utils/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final void Function() onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  //! password validation
  void passwordValidation() async {
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      return showDialog(
        context: context,
        builder: (context) => const Center(
          child: ShowDialogs(
            message: 'Passwords do not match!!',
          ),
        ),
      );
    }
  }

  // SignUp Function

  void signUp() async {
    if (firstNameController.text.trim().length < 3) {
      return showDialog(
          context: context,
          builder: (context) => const ShowDialogs(
              message: 'Name should be atleast 3 characters long'));
    }
    passwordController;

    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      String name1 = firstNameController.text.trim();
      final firstName = name1.substring(0, 1).toUpperCase() +
          name1.substring(1).toLowerCase();

      String name2 = lastNameController.text.trim();
      final lastName = name2.substring(0, 1).toUpperCase() +
          name2.substring(1).toLowerCase();
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'First Name': firstName,
        'Last Name': lastName,
        'Email': emailController.text.trim(),
      });

      if (context.mounted) {
        Navigator.pop(context);
      }
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.network(
                    'https://cdn-icons-png.flaticon.com/128/10164/10164387.png',
                    color: textColor,
                    height: 120),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'WELCOME BACK!',
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
                    controller: firstNameController, hintText: 'First Name'),
                MyTextfield(
                    controller: lastNameController, hintText: 'Last Name'),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                ),
                MyTextfield(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                ),
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                MyButton(buttonText: 'Register', onTap: signUp),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?  '),
                    TextButton(
                      onPressed: widget.onTap,
                      child: const Text(
                        'LOGIN!',
                        style: TextStyle(
                          color: designColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    )
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
