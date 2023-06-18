import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_using_rest_api/colors/colors.dart';
import 'package:to_do_app_using_rest_api/utils/dialog_box.dart';
import 'package:to_do_app_using_rest_api/utils/my_drawer.dart';
import 'package:to_do_app_using_rest_api/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final taskController = TextEditingController();

  List todoList = [];
  final currentUser = FirebaseAuth.instance.currentUser!;

  //! add new task to firebase
  void addNewTask() async {
    await FirebaseFirestore.instance
        .collection('Todo List')
        .doc(currentUser.email)
        .collection('Tasks')
        .add({
      'Task': taskController.text.trim(),
      'IsChecked': false,
      'Time': Timestamp.now()
    });
  }

  //todo: CREATE NEW TASK
  createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: taskController,
        onCancel: () => Navigator.pop(context),
        onSave: () {
          addNewTask();
          setState(() {
            todoList.add(taskController.text.trim());
            taskController.clear();
          });

          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 1,
          elevation: 0,
        ),
        backgroundColor: background,
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeColor.withOpacity(0.5),
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(currentUser.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Text(
                      'What\'s up, ${userData['First Name']} !',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 35),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text('What\'s Up !');
                  }
                  return const Text('What\'s Up !');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Today\'s Task',
              ),
              const SizedBox(
                height: 20,
              ),
              const TodoTile()
            ],
          ),
        ));
  }
}
