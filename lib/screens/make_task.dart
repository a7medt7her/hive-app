import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test/mod/coustm_textfiled.dart';

class MakeTask extends StatefulWidget {
  MakeTask({super.key});
  static const String routs = 'make_task';

  @override
  State<MakeTask> createState() => _MakeTaskState();
}

class _MakeTaskState extends State<MakeTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  late Box box;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  void openBox() {
    box = Hive.box('tasks');
    setState(() {});
  }

  void _saveIfNotEmpty() {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      box.add({
        'title': titleController.text,
        'content': contentController.text,
        'createdAt': DateTime.now().toString(),
      });

      print(box.get(0));
    } else {
      box.add({
        'title': 'No Title',
        'content': 'No Content',
        'createdAt': DateTime.now().toString(),
      });
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 6,
        backgroundColor: const Color.fromARGB(255, 153, 224, 215),
        centerTitle: true,
        title: const Text(
          'Make Task',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 250),
            child: Text('Title', style: TextStyle(fontSize: 50)),
          ),
          SizedBox(height: 20),
          TextFieldTapRegion(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CoustmTextfiled(
                controller: titleController,
                maxLines: 1,
                color: Color.fromARGB(255, 233, 1, 136),
                hint: 'Enter Title',
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(right: 220),
            child: Text('Content', style: TextStyle(fontSize: 50)),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CoustmTextfiled(
              controller: contentController,
              maxLines: 5,
              color: Color.fromARGB(255, 233, 1, 136),
              hint: 'Enter Content',
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _saveIfNotEmpty,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 153, 224, 215),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            child: Text(
              'Save Task',
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
