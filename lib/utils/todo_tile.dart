import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_using_rest_api/utils/delete_task_dialog_box.dart';
import '../colors/colors.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({super.key});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  bool isChecked = false;

  //! update the isChecked Varibale;
  updateIsChecked(String taskId, bool newIsChecked) async {
    setState(() {
      isChecked = !isChecked;
    });
    await FirebaseFirestore.instance
        .collection('Todo List')
        .doc(currentUser.email)
        .collection('Tasks')
        .doc(taskId)
        .update({'IsChecked': isChecked});
  }

  void confirmDelete(String taskId) async {
    await FirebaseFirestore.instance
        .collection('Todo List')
        .doc(currentUser.email)
        .collection('Tasks')
        .doc(taskId)
        .delete();
  }

  void deleteDialog(String taskId) {
    showDialog(
        context: context,
        builder: (context) => DeleteDialogBox(onDelete: () {
              confirmDelete(taskId);
              Navigator.pop(context);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('Todo List')
          .doc(currentUser.email)
          .collection('Tasks')
          .orderBy('Time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: darkbackground,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          final dataTask = snapshot.data!.docs;
          if (dataTask.isEmpty) {
            return const Expanded(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Task Added Yet',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              )),
            );
          }
          return Expanded(
              child: ListView.builder(
            itemCount: dataTask.length,
            itemBuilder: (context, index) {
              final task = dataTask[index].data();
              final isEvenIndex = index % 2 == 0;
              final borderColor = isEvenIndex ? themeColor : designColor;
              return Slidable(
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        deleteDialog(dataTask[index].id);
                      },
                      child: Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Icon(Icons.delete,
                                size: 30,
                                color: isEvenIndex ? themeColor : designColor),
                          )),
                    ),
                  )
                ]),
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: darkbackground.withOpacity(1)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          updateIsChecked(
                              dataTask[index].id, !task['IsChecked']);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: task['IsChecked']
                                  ? background
                                  : Colors.transparent,
                              border: Border.all(
                                  color: task['IsChecked']
                                      ? Colors.transparent
                                      : borderColor,
                                  width: 2)),
                          child: Center(
                            child: task['IsChecked']
                                ? const Icon(
                                    Icons.check,
                                    color: white,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.check,
                                    color: Colors.transparent,
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          task['Task'],
                          style: TextStyle(
                            decoration: task['IsChecked']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationThickness: 3,
                            decorationColor:
                                isEvenIndex ? themeColor : designColor,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ));
        }

        if (!snapshot.hasData) {
          return const Expanded(child: Center(child: Text('No Task Added')));
        }
        return const Expanded(child: Center(child: Text('Error Occured')));
      },
    );
  }
}
