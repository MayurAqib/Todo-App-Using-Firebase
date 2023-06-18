import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/colors/colors.dart';

import 'drawer_row.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return Drawer(
      backgroundColor: darkbackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: textColor.withOpacity(0.4))),
                          child: const Icon(
                            CupertinoIcons.back,
                            size: 30,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: darkbackground,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-photo/artificial-intelligence-humanoid-head-with-neural-network-thinks-futuristic-modern-3d-illustration_76964-5497.jpg'),
                    radius: 50,
                  ),
                  const SizedBox(height: 30),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(currentUser.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['First Name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              userData['Last Name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            )
                          ],
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text('');
                      }
                      return const Text('');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DrawerRow(
                    icon: Icons.bookmark_outline,
                    information: 'Templates',
                  ),
                  const DrawerRow(
                    icon: Icons.category_outlined,
                    information: 'Categories',
                  ),
                  const DrawerRow(
                    icon: Icons.bubble_chart_outlined,
                    information: 'Analytics',
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good',
                    style: TextStyle(
                        color: textColor.withOpacity(0.6), fontSize: 12),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Consistent',
                    style: TextStyle(fontSize: 17, color: Colors.greenAccent),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text(
                              'Are you sure?',
                              style: TextStyle(color: textColor),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: textColor),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: textColor),
                                  ))
                            ],
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: textColor.withOpacity(0.4))),
                        child: const Text(
                          'L O G O U T',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
